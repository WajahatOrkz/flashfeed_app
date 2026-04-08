import 'package:flashfeed_app/core/api/endpoints.dart';
import 'package:flashfeed_app/model/login_model.dart';
import 'package:flashfeed_app/model/send_otp_model.dart';
import 'package:flashfeed_app/model/verify_otp_model.dart';
import 'package:get/get.dart';

import '../core/api/api_client.dart';

class AuthRepo extends GetConnect {
  late ApiClient apiClient;
  AuthRepo({required this.apiClient});

  Future<bool> isUserExists(String email) async {
    var body = {'email': email};

    try {
      final response = await apiClient.putRequestWithHeader(
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
      final response = await apiClient.putRequestWithHeader(
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

  Future<SendOtpModel> sendMobileOtp(String email) async {
    var body = {'email': email};
    try {
      final response = await apiClient.postRequestWithHeader(
        url: EndPoints.sendMobileOtp,
        body: body,
      );

      if (response.statusCode == 200) {
        final result = SendOtpModel.fromJson(response.data);
        if (result.success == true) {
          return result;
        } else {
          throw Exception(result.message ?? 'Failed to send OTP');
        }
      } else {
        throw Exception(response.extractError('Failed to send OTP'));
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Failed to send OTP. Please try again.');
    }
  }

  Future<VerifyOtpModel> verifyMobileOtp(String email, String otp) async {
    var body = {'email': email, 'otp': otp};
    try {
      final response = await apiClient.putRequestWithHeader(
        url: EndPoints.verifyMobileOtp,
        body: body,
      );
      if (response.statusCode == 200 && response.data['success'] == true) {
        return VerifyOtpModel.fromJson(response.data);
      } else {
        throw Exception(response.extractError('OTP verification failed'));
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('OTP verification failed. Please try again.');
    }
  }

  Future<LoginModel> register({
    required String email,
    required String password,
    required String name,
    required String deviceId,
  }) async {
    var body = {
      'email': email,
      'password': password,
      'name': name,
      'termAndCondition': true,
      'deviceId': [deviceId],
    };
    try {
      final response = await apiClient.postRequestWithHeader(
        url: EndPoints.register,
        body: body,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return LoginModel.fromJson(response.data['data']);
      } else {
        throw Exception(response.extractError('Registration failed'));
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Registration failed. Please try again.');
    }
  }
}
