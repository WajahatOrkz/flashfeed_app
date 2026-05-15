import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/services/shared_preferences_services.dart';
import '../../data/repositories/profile_repo.dart';
import '../../../profile/data/models/passion_model.dart';
import 'profile_controller.dart';

class EditProfileController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final aboutController = TextEditingController();

  var passions = <String>[].obs;
  var isLoading = false.obs;

  late final ProfileRepo profileRepo;
  final ImagePicker _picker = ImagePicker();
  var pickedImage = Rxn<File>();
  var currentImageUrl = ''.obs;

  // Real user passions from API
  var allPassionsList = <PassionModel>[].obs;

  final availablePassions = <String>[];

  @override
  void onInit() {
    super.onInit();
    profileRepo = ProfileRepo(apiClient: ApiClient());
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    isLoading.value = true;
    final userId = SharedPreferencesService.instance.userId ?? '';

    if (userId.isEmpty) {
      isLoading.value = false;
      return;
    }

    // Call APIs in parallel
    await Future.wait([
      _getUserProfile(userId),
      _getUserImage(userId),
      _getAllPassions(),
      _getUserPassions(userId),
    ]);

    isLoading.value = false;
  }

  Future<void> _getUserProfile(String userId) async {
    final userProfile = await profileRepo.getUserProfile(userId);
    final user = userProfile.data?.users.firstOrNull;
    if (user != null) {
      nameController.text = user.name ?? '';
      emailController.text = user.email ?? '';
      aboutController.text = user.about ?? '';
    }
  }

  Future<void> _getUserImage(String userId) async {
    final imageUrl = await profileRepo.getUserImage(userId);

    currentImageUrl.value = imageUrl;
    print('Fetched image URL: $imageUrl');
  }

  Future<void> _getAllPassions() async {
    final passionsData = await profileRepo.getAllPassions();
    if (passionsData != null) {
      allPassionsList.value = passionsData;
      availablePassions.clear();
      availablePassions.addAll(allPassionsList.map((p) => p.name).toList());
    }
  }

  Future<void> _getUserPassions(String userId) async {
    final userPassions = await profileRepo.getUserPassions(userId);
    if (userPassions != null) {
      passions.value = userPassions.map((p) => p.name).toList();
    }
  }

  void togglePassion(String passion) {
    if (passions.contains(passion)) {
      passions.remove(passion);
    } else {
      passions.add(passion);
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      pickedImage.value = File(image.path);
    }
  }

  Future<void> updateProfile() async {
    print('Updating profile with:');
    print('Name: ${nameController.text}');
    final userId = SharedPreferencesService.instance.userId ?? '';
    print('UserId: "$userId"');
    if (userId.isEmpty) {
      print('❌ UserId is EMPTY — returning early, no API call');
      return;
    }

    print('✅ UserId found, starting update...');
    isLoading.value = true;

    // 1. Update Image if changed
    if (pickedImage.value != null) {
      print('📸 Uploading image: ${pickedImage.value!.path}');
      final imageSuccess = await profileRepo.updateUserImage(
        userId,
        pickedImage.value!,
      );
      print('📸 Image upload result: $imageSuccess');
    } else {
      print('📸 No new image picked, skipping image update');
    }

    // 2. Update User Info
    final passionIds = passions
        .map((passionName) {
          return allPassionsList
              .firstWhereOrNull((p) => p.name == passionName)
              ?.id;
        })
        .where((id) => id != null)
        .toList();

    final body = {
      "name": nameController.text,
      "about": aboutController.text,
      "favourite": [],
      "passion": passionIds,
    };

    final isSuccess = await profileRepo.updateUserInfo(userId, body);
    print('API response — isSuccess: $isSuccess');

    isLoading.value = false;

    if (isSuccess) {
      // Save updated name to SharedPreferences immediately
      await SharedPreferencesService.instance.setString(
        'user_name',
        nameController.text,
      );

      // Refresh profile view with updated data
      if (Get.isRegistered<UserProfileController>()) {
        await Get.find<UserProfileController>().refreshProfile();
      }
      Get.back();
      Get.snackbar(
        'Success',
        'Profile updated successfully!',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        'Error',
        'Failed to update profile',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    aboutController.dispose();
    super.onClose();
  }
}
