import 'package:flashfeed_app/core/routes/routes.dart';
import 'package:flashfeed_app/core/services/shared_preferences_services.dart';
import 'package:flashfeed_app/core/utils/app_snackbar.dart';
import 'package:flashfeed_app/core/validation/validations.dart';
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

  // Forgot Password Controllers
  final forgotPasswordEmailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final RxBool isLoading = false.obs;
  final isUserExists = RxnBool();
  final continueButtonEnabled = true.obs;
  final termsEnabled = false.obs;
  final isUserLogin = false.obs;

  // Password visibility toggles
  final loginPasswordVisible = false.obs;
  final signupPasswordVisible = false.obs;
  final newPasswordVisible = false.obs;
  final confirmPasswordVisible = false.obs;

  // OTP Controllers (4 boxes)
  final List<TextEditingController> otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> otpFocusNodes = List.generate(4, (_) => FocusNode());
  final RxBool isOtpLoading = false.obs;
  final RxBool isForgotOtpLoading = false.obs;
  final RxBool isLogoutLoading = false.obs;

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
    forgotPasswordEmailController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    for (final c in otpControllers) c.dispose();
    for (final f in otpFocusNodes) f.dispose();
    super.onClose();
  }

  void resetAuthState() {
    isUserExists.value = null;
    loginPasswordController.clear();
    signupNameController.clear();
    signupPasswordController.clear();
    loginPasswordVisible.value = false;
    signupPasswordVisible.value = false;
  }

  void clearForgotPasswordState() {
    forgotPasswordEmailController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
    newPasswordVisible.value = false;
    confirmPasswordVisible.value = false;
    for (final c in otpControllers) c.clear();
  }

  // user existence check method
  Future<void> checkUserExists(String email) async {
    final emailError = Validators.validateEmail(email);
    if (emailError != null) {
      AppSnackbar.error('Invalid Email', emailError);
      return;
    }

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
      AppSnackbar.error('Error', 'Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  // --- Login Methods ---
  Future<void> userLogin() async {
    final emailError = Validators.validateEmail(
      loginEmailController.text.trim(),
    );
    if (emailError != null) {
      AppSnackbar.error('Invalid Email', emailError);
      return;
    }
    final passwordError = Validators.validateLoginPassword(
      loginPasswordController.text.trim(),
    );
    if (passwordError != null) {
      AppSnackbar.error('Invalid Password', passwordError);
      return;
    }

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
        Get.toNamed(AppRoutes.feedRoute);
      }

      AppSnackbar.success(
        'Login Successful',
        'Welcome back, ${response.name ?? 'User'}!',
      );
    } catch (e) {
      AppSnackbar.error(
        'Login Failed',
        e.toString().replaceAll('Exception: ', ''),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // --- Signup Methods ---
  Future<void> sendMobileOtp() async {
    final nameVal = signupNameController.text.trim();
    if (nameVal.isEmpty) {
      AppSnackbar.error('Invalid Name', 'Name is required');
      return;
    }
    final emailError = Validators.validateEmail(
      loginEmailController.text.trim(),
    );
    if (emailError != null) {
      AppSnackbar.error('Invalid Email', emailError);
      return;
    }
    final passwordError = Validators.validateSignupPassword(
      signupPasswordController.text.trim(),
    );
    if (passwordError != null) {
      AppSnackbar.error('Invalid Password', passwordError);
      return;
    }
    if (!termsEnabled.value) {
      AppSnackbar.error(
        'Terms Required',
        'Please accept the terms and conditions',
      );
      return;
    }

    try {
      isLoading.value = true;

      await authRepo.sendMobileOtp(loginEmailController.text.trim());

      isLoading.value = false;

      for (final c in otpControllers) c.clear();
      Get.bottomSheet(
        OtpBottomSheet(
          title: 'Enter OTP',
          email: loginEmailController.text.trim(),
          onVerify: verifyOtp,
          onResend: sendMobileOtp,
          isLoading: isOtpLoading,
        ),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
      );
    } catch (e) {
      isLoading.value = false;
      AppSnackbar.error(
        'Failed to Send OTP',
        e.toString().replaceAll('Exception: ', ''),
      );
    }
  }

  Future<void> verifyOtp() async {
    final otp = otpControllers.map((c) => c.text).join();
    if (otp.length < 4) {
      AppSnackbar.error(
        'Invalid OTP',
        'Please enter the complete 4-digit OTP.',
      );
      return;
    }

    try {
      isOtpLoading.value = true;

      await authRepo.verifyMobileOtp(loginEmailController.text.trim(), otp);

      const deviceId = 'dev-test-device-001';
      // register api function yahan call ho raha hai
      final user = await authRepo.register(
        email: loginEmailController.text.trim(),
        password: signupPasswordController.text.trim(),
        name: signupNameController.text.trim(),
        deviceId: deviceId,
      );

      if (user.authToken != null) {
        await SharedPreferencesService.instance.saveUserSession(
          token: user.authToken!,
          email: user.email ?? loginEmailController.text.trim(),
          name: user.name ?? signupNameController.text.trim(),
          deviceId: deviceId,
        );
        isUserLogin.value = true;
      }

      isOtpLoading.value = false;
      Get.back(); // close bottom sheet
      Get.toNamed(AppRoutes.feedRoute);
    } catch (e) {
      isOtpLoading.value = false;
      AppSnackbar.error(
        'Registration Failed',
        e.toString().replaceAll('Exception: ', ''),
      );
    }
  }

  Future<void> forgotPasswordSendOtp() async {
    final emailError = Validators.validateEmail(
      forgotPasswordEmailController.text.trim(),
    );
    if (emailError != null) {
      AppSnackbar.error('Invalid Email', emailError);
      return;
    }

    try {
      isLoading.value = true;
      await authRepo.forgotPasswordSendOtp(
        forgotPasswordEmailController.text.trim(),
      );

      for (final c in otpControllers) c.clear();
      Get.bottomSheet(
        OtpBottomSheet(
          title: 'Verify OTP',
          email: forgotPasswordEmailController.text.trim(),
          onVerify: verifyForgotPasswordOtp,
          onResend: forgotPasswordSendOtp,
          isLoading: isForgotOtpLoading,
        ),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
      );
    } catch (e) {
      AppSnackbar.error(
        'Failed to Send OTP',
        e.toString().replaceAll('Exception: ', ''),
      );
    } finally {
      isLoading.value = false; // ✅ Hamesha reset hoga
    }
  }

  Future<void> verifyForgotPasswordOtp() async {
    final otp = otpControllers.map((c) => c.text).join();
    if (otp.length < 4) {
      AppSnackbar.error(
        'Invalid OTP',
        'Please enter the complete 4-digit OTP.',
      );
      return;
    }

    try {
      isForgotOtpLoading.value = true;
      await authRepo.forgotPasswordVerifyOtp(
        forgotPasswordEmailController.text.trim(),
        otp,
      );
      isForgotOtpLoading.value = false;
      Get.back(); // close bottom sheet
      Get.toNamed(AppRoutes.resetPasswordRoute);
    } catch (e) {
      isForgotOtpLoading.value = false;
      AppSnackbar.error(
        'OTP Verification Failed',
        e.toString().replaceAll('Exception: ', ''),
      );
    }
  }

  Future<void> changePassword() async {
    final newPass = newPasswordController.text.trim();
    final confirmPass = confirmPasswordController.text.trim();

    final passError = Validators.validateSignupPassword(newPass);
    if (passError != null) {
      AppSnackbar.error('Invalid Password', passError);
      return;
    }

    if (newPass != confirmPass) {
      AppSnackbar.error('Password Mismatch', 'Passwords do not match.');
      return;
    }

    try {
      isLoading.value = true;

      await authRepo.changePassword(
        forgotPasswordEmailController.text.trim(),
        newPass,
      );

      AppSnackbar.success(
        'Password Changed',
        'Your password has been updated. Please log in.',
      );

      Get.offAllNamed(AppRoutes.loginRoute);
    } catch (e) {
      AppSnackbar.error('Failed', e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      isLogoutLoading.value = true;
      final deviceId =
          SharedPreferencesService.instance.deviceId ??
          DateTime.now().millisecondsSinceEpoch.toString();
      await authRepo.logout(deviceId);
      await SharedPreferencesService.instance.clearUserSession();
      isLogoutLoading.value = false;
      Get.offAllNamed(AppRoutes.initialAuthRoute);
    } catch (e) {
      isLogoutLoading.value = false;
      AppSnackbar.error(
        'Logout Failed',
        e.toString().replaceAll('Exception: ', ''),
      );
    }
  }
}
