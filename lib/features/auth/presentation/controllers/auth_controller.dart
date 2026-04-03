import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../../core/routes/routes.dart';

class AuthController extends GetxController {
  // Login Controllers
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  // Signup Controllers
  final signupNameController = TextEditingController();
  final signupEmailController = TextEditingController();
  final signupPasswordController = TextEditingController();

  @override
  void onClose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    signupNameController.dispose();
    signupEmailController.dispose();
    signupPasswordController.dispose();
    super.onClose();
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
    print('Signup with Name: ${signupNameController.text}, Email: ${signupEmailController.text}');
  }

  void navigateToLogin() {
    Get.back();
  }

  void socialSignup(String provider) {
    print('Social signup with $provider');
  }
}
