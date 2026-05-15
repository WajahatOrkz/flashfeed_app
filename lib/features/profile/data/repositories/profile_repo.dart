import 'dart:io';
import 'package:http_parser/http_parser.dart';
import '../../../../../core/api/api_client.dart';
import '../../../../../core/api/endpoints.dart';
import '../models/passion_model.dart';
import '../models/user_profile_model.dart';

class ProfileRepo {
  final ApiClient apiClient;
  ProfileRepo({required this.apiClient});

  Future<UserProfileModel?> getUserProfile(String userId) async {
    try {
      final response = await apiClient.getRequest(
        url: '${EndPoints.getUserProfile}/$userId',
      );
      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['data'] ?? response.data;
        return UserProfileModel.fromJson(data);
      }
    } catch (e) {
      print("Error fetching profile: $e");
    }
    return null;
  }

  Future<String?> getUserImage(String userId) async {
    try {
      final response = await apiClient.getRequest(
        url: '${EndPoints.getUserImage}/$userId',
      );
      if (response.statusCode == 200 && response.data != null) {
        return response.data['data'] as String?;
      }
    } catch (e) {
      print("Error fetching user image: $e");
    }
    return null;
  }

  Future<List<PassionModel>?> getAllPassions() async {
    try {
      final response = await apiClient.getRequest(url: EndPoints.getPassions);
      if (response.statusCode == 200 && response.data != null) {
        final passionsData = response.data['data']?['passions'] as List?;
        if (passionsData != null) {
          return passionsData.map((p) => PassionModel.fromJson(p)).toList();
        }
      }
    } catch (e) {
      print("Error fetching passions: $e");
    }
    return null;
  }

  Future<List<PassionModel>?> getUserPassions(String userId) async {
    try {
      final response = await apiClient.getRequest(
        url: '${EndPoints.getUserPassions}/$userId',
      );
      if (response.statusCode == 200 && response.data != null) {
        final userPassionsData = response.data['data']?['Passion'] as List?;
        if (userPassionsData != null) {
          return userPassionsData.map((p) => PassionModel.fromJson(p)).toList();
        }
      }
    } catch (e) {
      print("Error fetching user passions: $e");
    }
    return null;
  }

  Future<bool> updateUserImage(String userId, File imageFile) async {
    try {
      final ext = imageFile.path.split('.').last;
      MediaType mt = MediaType('image', ext == 'png' ? 'png' : 'jpeg');

      final response = await apiClient.postMultipartRequestFileProgress(
        url: '${EndPoints.updateUserImage}/$userId',
        isFile: true,
        filePath: imageFile.path,
        filed: 'file',
        mediaType: mt,
        body: {},
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print("Error updating user image: $e");
      return false;
    }
  }

  Future<bool> updateUserInfo(String userId, Map<String, dynamic> body) async {
    try {
      final response = await apiClient.putRequestWithHeader(
        url: '${EndPoints.updateUserInfo}/$userId',
        body: body,
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print("Error updating user info: $e");
      return false;
    }
  }
}
