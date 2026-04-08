import 'package:flashfeed_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackbar {
  AppSnackbar._();

  static void success(String title, String message) {
    _show(
      title: title,
      message: message,
      backgroundColor: AppColors.primaryColor,
      icon: Icons.check_circle_outline_rounded,
    );
  }

  static void error(String title, String message) {
    _show(
      title: title,
      message: message,
      backgroundColor: AppColors.errorRed,
      icon: Icons.error_outline_rounded,
    );
  }

  static void info(String title, String message) {
    _show(
      title: title,
      message: message,
      backgroundColor: AppColors.secondaryColor,
      icon: Icons.info_outline_rounded,
    );
  }

  static void _show({
    required String title,
    required String message,
    required Color backgroundColor,
    required IconData icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();

    Get.snackbar(
      title,
      message,
      titleText: Text(
        title,
        style: const TextStyle(
          color: AppColors.textColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          color: AppColors.textColor,
          fontSize: 13,
        ),
      ),
      icon: Icon(icon, color: AppColors.textColor, size: 28),
      backgroundColor: backgroundColor,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      duration: duration,
      animationDuration: const Duration(milliseconds: 300),
      forwardAnimationCurve: Curves.easeOut,
      reverseAnimationCurve: Curves.easeIn,
    );
  }
}
