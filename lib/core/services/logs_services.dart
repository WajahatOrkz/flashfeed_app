// ignore_for_file: unnecessary_cast

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class LogsService {
  static final LogsService _instance = LogsService._internal();
  factory LogsService() => _instance;
  LogsService._internal();

  final _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 3,
      lineLength: 120,
      colors: true,
      printEmojis: true,
    ),
    filter: DevelopmentFilter(),
    output: ConsoleOutput(),
  );

  void logRequest(
    String url,
    String method,
    Map<String, String> headers,
    dynamic body,
  ) {
    final requestLog = StringBuffer();
    requestLog.writeln('\n🌐 REQUEST DETAILS');
    requestLog.writeln('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    requestLog.writeln('URL: $url');
    requestLog.writeln('METHOD: $method');
    requestLog.writeln(
      'HEADERS: ${const JsonEncoder.withIndent('  ').convert(headers)}',
    );

    if (body != null) {
      String bodyStr;
      if (body is String) {
        bodyStr = body;
      } else if (body is Map) {
        // Handle Maps that might contain File objects
        // Convert to Map<String, dynamic> to avoid type issues on Android
        final Map<String, dynamic> safeBody = {};
        final bodyMap = Map<String, dynamic>.from(body as Map);
        bodyMap.forEach((key, value) {
          if (value is File) {
            safeBody[key] = 'File(${value.path})';
          } else if (value is List) {
            safeBody[key] = value
                .map((item) => item is File ? 'File(${item.path})' : item)
                .toList();
          } else {
            safeBody[key] = value;
          }
        });
        bodyStr = const JsonEncoder.withIndent('  ').convert(safeBody);
      } else {
        bodyStr = body.toString();
      }
      requestLog.writeln('BODY: $bodyStr');
    }

    _logger.i(requestLog.toString());
  }

  void logResponse(http.Response response, Duration duration) {
    final responseLog = StringBuffer();
    responseLog.writeln('\n📨 RESPONSE DETAILS [${duration.inMilliseconds}ms]');
    responseLog.writeln('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    responseLog.writeln('STATUS: ${response.statusCode}');
    responseLog.writeln('URL: ${response.request?.url}');

    if (response.headers.isNotEmpty) {
      responseLog.writeln(
        'HEADERS: ${const JsonEncoder.withIndent('  ').convert(response.headers)}',
      );
    }

    if (response.body.isNotEmpty) {
      try {
        final dynamic decodedBody = json.decode(response.body);
        final prettyJson = const JsonEncoder.withIndent(
          '  ',
        ).convert(decodedBody);
        responseLog.writeln('BODY: $prettyJson');
      } catch (e) {
        responseLog.writeln('BODY: ${response.body}');
      }
    }

    final icon =
        response.statusCode >= 200 && response.statusCode < 300 ? '✅' : '❌';
    _logger.i('$icon ${responseLog.toString()}');
  }

  void logCache(String action, String endpoint) {
    switch (action.toLowerCase()) {
      case 'hit':
        _logger.i('📦 Cache Hit: $endpoint');
        break;
      case 'miss':
        _logger.i('🔍 Cache Miss: $endpoint');
        break;
      case 'store':
        _logger.i('💾 Cache Stored: $endpoint');
        break;
      case 'clear':
        _logger.i('🧹 Cache Cleared');
        break;
      default:
        _logger.i('🔄 Cache Operation ($action): $endpoint');
    }
  }

  void logWarning(String message) {
    _logger.w('⚠️ $message');
  }

  void logError(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e('❌ $message', error: error, stackTrace: stackTrace);
  }

  void logInfo(String message) {
    _logger.i('ℹ️ $message');
  }

  void logDebug(String message) {
    _logger.d('🔍 $message');
  }

  void logVerbose(String message) {
    _logger.t('�� $message');
  }
}