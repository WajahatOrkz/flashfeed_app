import 'package:flashfeed_app/core/api/endpoints.dart';
import 'package:flashfeed_app/model/login_model.dart';
import 'package:get/get.dart';

import '../core/api/api_client.dart';

class AuthRepo extends GetConnect {
  late ApiClient _apiClient;
  static final _instance = AuthRepo._constructor();

  factory AuthRepo() {
    return _instance;
  }

  AuthRepo._constructor() {
    _apiClient = ApiClient();
  }

  Future<bool> isUserExists(String email) async {
    var body = {'email': email};

    try {
      final response = await _apiClient.putRequestWithHeader(
        url: EndPoints.checkUser,
        body: body,
      );

      if (response.statusCode == 200) {
        return response.data['message'] == "User Found" &&
            response.data['userid'] != null;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<LoginModel> login(String email, String password) async {
    var body = {
      'email': email,
      'password': password,
      'deviceId': 'dev-test-device-001',
    };

    try {
      final response = await _apiClient.putRequestWithHeader(
        url: EndPoints.login,
        body: body,
      );

      if (response.statusCode == 200) {
        return LoginModel.fromJson(response.data['user']);
      } else {
        throw Exception(response.extractError('Login failed'));
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Login failed. Please try again.');
    }
  }
}
