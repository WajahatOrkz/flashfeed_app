import 'dart:convert';

import 'package:flashfeed/core/api/endpoints.dart';
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
      final response = await _apiClient.put(
        EndPoints.checkUser,
        jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return response.body['message'] == "User Found" && response.body['userid'] != null;
      } else {
        print('Error checking user existence: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error checking user existence: $e');
      return false;
    }
  }
}
