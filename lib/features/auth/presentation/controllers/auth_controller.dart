import 'package:flashfeed_app/repositories/auth_repo.dart';
import 'package:flutter/widgets.dart';
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

  Future checkUserExists(String email) async {
    isLoading.value = true;

    // Clear extra fields before showing new state, keep email
    loginPasswordController.clear();
    signupNameController.clear();
    signupPasswordController.clear();
    loginPasswordVisible.value = false;
    signupPasswordVisible.value = false;

    isUserExists.value = await authRepo.isUserExists(email);

    isLoading.value = false;
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
  void login() {
    print('Login with Email: ${loginEmailController.text}');
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
