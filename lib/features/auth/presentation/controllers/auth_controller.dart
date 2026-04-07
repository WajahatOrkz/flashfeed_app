import 'package:flashfeed_app/core/routes/routes.dart';
import 'package:flashfeed_app/core/services/shared_preferences_services.dart';
import 'package:flashfeed_app/core/theme/app_colors.dart';
import 'package:flashfeed_app/features/auth/presentation/widgets/otp_bottom_sheet.dart';
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

  // OTP Controllers (6 boxes)
  final List<TextEditingController> otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> otpFocusNodes = List.generate(6, (_) => FocusNode());
  final RxBool isOtpLoading = false.obs;

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
    for (final c in otpControllers) c.dispose();
    for (final f in otpFocusNodes) f.dispose();
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
        await SharedPreferencesService.instance.saveUserSession(
          token: response.authToken!,
          email: response.email ?? '',
          name: response.name ?? '',
        );
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

  // --- Signup Methods ---
  Future<void> signup() async {
    try {
      isLoading.value = true;
      // Step 1: Register user
      final response = await authRepo.register(
        signupNameController.text.trim(),
        loginEmailController.text.trim(),
        signupPasswordController.text.trim(),
      );
      // Step 2: Send OTP using the token from registration
      _signupToken = response.authToken!;
      await authRepo.sendOtpToEmail(_signupToken);
      isLoading.value = false;
      // Step 3: Open OTP bottom sheet
      for (final c in otpControllers) c.clear();
      Get.bottomSheet(
        const OtpBottomSheet(),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Signup Failed',
        e.toString().replaceAll('Exception: ', ''),
        backgroundColor: const Color(0xFFE53935),
        colorText: const Color(0xFFFFFFFF),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 10,
        duration: const Duration(seconds: 4),
      );
    }
  }

  Future<void> verifyOtp() async {
    final otp = otpControllers.map((c) => c.text).join();
    final email = loginEmailController.text.trim();
    try {
      isOtpLoading.value = true;
      await authRepo.verifyOtp(email, otp);
      isOtpLoading.value = false;
      Get.back(); // close bottom sheet
      Get.snackbar(
        'Email Verified',
        'Your email has been verified successfully.',
        backgroundColor: AppColors.primaryColor,
        colorText: const Color(0xFFFFFFFF),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 10,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      isOtpLoading.value = false;
      Get.snackbar(
        'Invalid OTP',
        e.toString().replaceAll('Exception: ', ''),
        backgroundColor: const Color(0xFFE53935),
        colorText: const Color(0xFFFFFFFF),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 10,
        duration: const Duration(seconds: 4),
      );
    }
  }
}
