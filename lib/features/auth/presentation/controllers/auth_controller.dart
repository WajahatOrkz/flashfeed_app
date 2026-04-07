import 'package:flashfeed_app/core/constants/app_config.dart';
import 'package:flashfeed_app/core/routes/routes.dart';
import 'package:flashfeed_app/core/services/shared_preferences_services.dart';
import 'package:flashfeed_app/core/theme/app_colors.dart';
import 'package:flashfeed_app/repositories/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  // Login Controllers
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  // Signup Controllers
  final signupNameController = TextEditingController();
  final signupEmailController = TextEditingController();
  final signupPasswordController = TextEditingController();

  final RxBool isLoading = false.obs;
  final isUserExists = RxnBool();
  final continueButtonEnabled = true.obs;
  final termsEnabled = false.obs;
  final isUserLogin = false.obs;

  // Password visibility toggles
  final loginPasswordVisible = false.obs;
  final signupPasswordVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    loginEmailController.addListener(_onEmailChanged);
  }

  void _onEmailChanged() {
    // As soon as email is edited while in login/signup mode, reset back to initial
    if (isUserExists.value != null) {
      isUserExists.value = null;
      loginPasswordController.clear();
      signupNameController.clear();
      signupPasswordController.clear();
      loginPasswordVisible.value = false;
      signupPasswordVisible.value = false;
      termsEnabled.value = false;
    }
  }

  @override
  void onClose() {
    loginEmailController.removeListener(_onEmailChanged);
    loginEmailController.dispose();
    loginPasswordController.dispose();
    signupNameController.dispose();
    signupEmailController.dispose();
    signupPasswordController.dispose();
    super.onClose();
  }

  Future<void> checkUserExists(String email) async {
    try {
      isLoading.value = true;

      // Clear extra fields before showing new state, keep email
      loginPasswordController.clear();
      signupNameController.clear();
      signupPasswordController.clear();
      loginPasswordVisible.value = false;
      signupPasswordVisible.value = false;

      isUserExists.value = await authRepo.isUserExists(email);
    } catch (e) {
      debugPrint('[checkUserExists] Error: $e');
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        backgroundColor: const Color(0xFFE53935),
        colorText: const Color(0xFFFFFFFF),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 10,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void resetAuthState() {
    isUserExists.value = null;
    loginPasswordController.clear();
    signupNameController.clear();
    signupPasswordController.clear();
    loginPasswordVisible.value = false;
    signupPasswordVisible.value = false;
  }

  // --- Login Methods ---
  Future<void> userLogin() async {
    print("Sign In button is pressing");
    try {
      isLoading.value = true;
      final response = await authRepo.login(
        loginEmailController.text.trim(),
        loginPasswordController.text.trim(),
      );

      if (response.authToken != null) {
        final prefs = SharedPreferencesService.instance;
        await prefs.setString(AppConfig.tokenKey, response.authToken!);
        await prefs.setString(AppConfig.userEmailKey, response.email ?? '');
        await prefs.setString(AppConfig.userNameKey, response.name ?? '');
        await prefs.setBool(AppConfig.isLoggedInKey, true);
        isUserLogin.value = true;
        Get.toNamed(AppRoutes.feed);
      }

      Get.snackbar(
        'Login Successful',
        'Welcome back, ${response.name ?? 'User'}!',
        backgroundColor: AppColors.primaryColor,
        colorText: const Color(0xFFFFFFFF),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 10,
        duration: const Duration(seconds: 4),
      );
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString().replaceAll('Exception: ', ''),
        backgroundColor: const Color(0xFFE53935),
        colorText: const Color(0xFFFFFFFF),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 10,
        duration: const Duration(seconds: 4),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToSignup() {
    // Get.toNamed(AppRoutes.signup);
  }

  void socialLogin(String provider) {
    print('Social login with $provider');
  }

  // --- Signup Methods ---
  void signup() {
    print(
      'Signup with Name: ${signupNameController.text}, Email: ${signupEmailController.text}',
    );
  }

  void navigateToLogin() {
    Get.back();
  }

  void socialSignup(String provider) {
    print('Social signup with $provider');
  }
}
