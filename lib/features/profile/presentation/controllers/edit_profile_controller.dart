import 'package:get/get.dart';
import 'package:flutter/material.dart';

class EditProfileController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final aboutController = TextEditingController();

  var passions = <String>[].obs;

  // Static list for UI simulation of API data
  final availablePassions = <String>[
    'Photography',
    'Traveling',
    'Music',
    'Gaming',
    'Coding',
    'Reading',
    'Sports',
    'Art',
    'Cooking',
    'Dancing',
    'Writing',
    'Fitness',
  ];

  @override
  void onInit() {
    super.onInit();
    // Pre-fill fake data to match the UI state shown in the design
    nameController.text;
    emailController.text;
    // aboutController.text = ''; // Empty to show hint
  }

  void togglePassion(String passion) {
    if (passions.contains(passion)) {
      passions.remove(passion);
    } else {
      passions.add(passion);
    }
  }

  void updateProfile() {
    // Logic to update profile
    Get.snackbar(
      'Success',
      'Profile updated successfully!',
      snackPosition: SnackPosition.BOTTOM,
    );
    Get.back();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    aboutController.dispose();
    super.onClose();
  }
}
