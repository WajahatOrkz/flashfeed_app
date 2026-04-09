// ignore_for_file: prefer_is_empty, unnecessary_null_comparison, unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart'
    hide Response, MultipartFile; // Hide to avoid conflict with http package
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../model/response_model.dart';
import '../services/logs_services.dart';
import '../services/shared_preferences_services.dart';

class ApiClient extends GetConnect {
  factory ApiClient() {
    return _instance;
  }

  static const int _requestTimeOut = 120;
  static final ApiClient _instance = ApiClient._constructor();

  ApiClient._constructor();
  String get kUserToken => SharedPreferencesService.instance.token ?? '';
  final _logsService = LogsService();

  /// Active HTTP clients for Android uploads, keyed by file path.
  final Map<String, http.Client> _activeUploadClients = {};

  void cancelActiveUpload(String filePath) {
    final client = _activeUploadClients.remove(filePath);
    if (client != null) {
      client.close();
      if (kDebugMode) {
        print('HTTPClient: Closed HTTP client for $filePath');
      }
    }
  }

  /// GET Request
  Future<ResponseModel> getRequest({required String url}) async {
    String methodName = "getRequest";
    final startTime = DateTime.now();

    try {
      final token = kUserToken.isEmpty ? null : kUserToken;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        if (token != null) 'token': token,
      };

      _logsService.logRequest(url, 'GET', headers, null);

      // FIX: Use http.get with Uri.parse to avoid GetConnect conflict
      http.Response response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: _requestTimeOut));

      final duration = DateTime.now().difference(startTime);

      _logsService.logResponse(response, duration);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var decodedData = jsonDecode(response.body);
        return ResponseModel.named(
          statusCode: response.statusCode,
          statusDescription: "Success",
          data: decodedData,
        );
      } else {
        return ResponseModel.named(
          statusCode: response.statusCode,
          statusDescription: "Error",
          data: response.body,
        );
      }
    } on TimeoutException catch (e, stackTrace) {
      _logsService.logError('GET request timeout for $url', e, stackTrace);
      return ResponseModel.named(
        statusCode: 408,
        statusDescription: "Request TimeOut",
        data: "Request TimeOut",
      );
    } on SocketException catch (e, stackTrace) {
      _logsService.logError('Socket error for $url', e, stackTrace);
      return ResponseModel.named(
        statusCode: 400,
        statusDescription: "No Internet Connection",
        data: "Bad Request",
      );
    } catch (e, stackTrace) {
      _logsService.logError('Server error for $url', e, stackTrace);
      return ResponseModel.named(
        statusCode: 500,
        statusDescription: "Server Error",
        data: e.toString(),
      );
    }
  }

  /// POST Request
  Future<ResponseModel> postRequestWithHeader({
    required String url,
    dynamic body,
    Map<String, String>? extraHeaders,
  }) async {
    String methodName = "postRequestWithHeader";
    final startTime = DateTime.now();

    try {
      final token = kUserToken.isEmpty ? null : kUserToken;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        if (token != null) 'token': token,
      };

      if (extraHeaders != null) headers.addAll(extraHeaders);

      _logsService.logRequest(url, 'POST', headers, body);

      http.Response response = await http
          .post(Uri.parse(url), headers: headers, body: jsonEncode(body))
          .timeout(const Duration(seconds: _requestTimeOut));

      final duration = DateTime.now().difference(startTime);
      _logsService.logResponse(response, duration);

      ResponseModel responseModel = ResponseModel();
      if (response.body.length > 0) {
        responseModel.statusCode = response.statusCode;
        responseModel.statusDescription = "Success";
        responseModel.data = jsonDecode(response.body);
      }
      return responseModel;
    } on TimeoutException catch (e, _) {
      return ResponseModel.named(
        statusCode: 408,
        statusDescription: "Timeout",
        data: "",
      );
    } catch (e) {
      return ResponseModel.named(
        statusCode: 500,
        statusDescription: "Error",
        data: e.toString(),
      );
    }
  }

  /// PUT Request
  Future<ResponseModel> putRequestWithHeader({
    required String url,
    dynamic body,
    Map<String, String>? extraHeaders,
  }) async {
    final startTime = DateTime.now();
    try {
      final token = kUserToken.isEmpty ? null : kUserToken;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        if (token != null) 'token': token,
      };
      if (extraHeaders != null) headers.addAll(extraHeaders);

      _logsService.logRequest(url, 'PUT', headers, body);

      http.Response response = await http
          .put(Uri.parse(url), headers: headers, body: jsonEncode(body))
          .timeout(const Duration(seconds: _requestTimeOut));

      _logsService.logResponse(response, DateTime.now().difference(startTime));

      return ResponseModel.named(
        statusCode: response.statusCode,
        statusDescription: "Success",
        data: jsonDecode(response.body),
      );
    } catch (e) {
      return ResponseModel.named(
        statusCode: 500,
        statusDescription: "Error",
        data: "",
      );
    }
  }

  /// DELETE Request
  Future<ResponseModel> deleteRequestWithHeader({required String url}) async {
    final startTime = DateTime.now();
    try {
      final token = kUserToken.isEmpty ? null : kUserToken;
      Map<String, String> headers = {if (token != null) 'token': token};

      _logsService.logRequest(url, 'DELETE', headers, null);

      http.Response response = await http
          .delete(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: _requestTimeOut));

      _logsService.logResponse(response, DateTime.now().difference(startTime));

      return ResponseModel.named(
        statusCode: response.statusCode,
        statusDescription: "Deleted",
        data: response.body,
      );
    } catch (e) {
      return ResponseModel.named(statusCode: 500, data: "");
    }
  }

  /// Multipart with Progress (Dio/Http hybrid)
  Future<ResponseModel> postMultipartRequestFileProgress({
    required String url,
    dynamic body,
    bool isFile = false,
    String? filePath,
    String? filed,
    MediaType? mediaType,
    String? thumbnail,
    d.CancelToken? cancelToken,
    void Function(int sentBytes, int totalBytes)? onProgress,
  }) async {
    final startTime = DateTime.now();

    if (Platform.isAndroid && isFile && filePath != null) {
      return _uploadWithHttpPackage(
        url: url,
        body: body,
        filePath: filePath,
        filed: filed,
        mediaType: mediaType,
        thumbnail: thumbnail,
        onProgress: onProgress,
        methodName: "MultipartProgress",
        startTime: startTime,
        cancelToken: cancelToken,
      );
    }

    try {
      final token = kUserToken.isEmpty ? null : kUserToken;
      var headers = <String, String>{if (token != null) 'token': token};

      d.Dio dio = d.Dio();
      dio.options.headers.addAll(headers);
      d.FormData formData = d.FormData.fromMap(body);

      if (isFile && filePath != null) {
        formData.files.add(
          MapEntry(
            filed!,
            await d.MultipartFile.fromFile(filePath, contentType: mediaType),
          ),
        );
        if (thumbnail != null) {
          formData.files.add(
            MapEntry('thumbnail', await d.MultipartFile.fromFile(thumbnail)),
          );
        }
      }

      d.Response response = await dio.post(
        url,
        data: formData,
        cancelToken: cancelToken,
        onSendProgress: onProgress,
      );

      return ResponseModel.named(
        statusCode: response.statusCode ?? 200,
        data: response.data,
      );
    } catch (e) {
      return ResponseModel.named(statusCode: 500, data: e.toString());
    }
  }

  Future<ResponseModel> _uploadWithHttpPackage({
    required String url,
    dynamic body,
    required String filePath,
    String? filed,
    MediaType? mediaType,
    String? thumbnail,
    void Function(int sentBytes, int totalBytes)? onProgress,
    required String methodName,
    required DateTime startTime,
    d.CancelToken? cancelToken,
  }) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers['token'] = kUserToken;

      if (body != null && body is Map) {
        body.forEach(
          (key, value) => request.fields[key.toString()] = value.toString(),
        );
      }

      request.files.add(
        await http.MultipartFile.fromPath(
          filed ?? 'file',
          filePath,
          contentType: mediaType,
        ),
      );

      final client = http.Client();
      _activeUploadClients[filePath] = client;

      final streamedResponse = await client.send(request);
      final response = await http.Response.fromStream(streamedResponse);

      _activeUploadClients.remove(filePath);
      client.close();

      return ResponseModel.named(
        statusCode: response.statusCode,
        data: jsonDecode(response.body),
      );
    } catch (e) {
      return ResponseModel.named(statusCode: 500, data: e.toString());
    }
  }
}
