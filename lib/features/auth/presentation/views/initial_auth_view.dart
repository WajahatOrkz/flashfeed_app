import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/auth_controller.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/loading_overlay.dart';
import '../widgets/login_form_fields.dart';
import '../widgets/signup_form_fields.dart';

class InitialAuthView extends GetView<AuthController> {
  const InitialAuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 60),

                  // Logo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.bolt,
                        color: AppColors.lightningBlue,
                        size: 80,
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.camera_alt_rounded,
                        color: AppColors.iconGrey,
                        size: 60,
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // Heading
                  const Text(
                    'Enter your email and password to get you on board',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Email label + field (always shown)
                  const Text(
                    'Email',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: controller.loginEmailController,
                    hintText: 'Enter your email',
                    fieldBgColor: AppColors.fieldBgColor,
                    borderColor: AppColors.borderColor,
                  ),

                  // Dynamic extra fields based on isUserExists
                  Obx(() {
                    final exists = controller.isUserExists.value;

                    if (exists == null) {
                      // Initial state — only email shown, nothing extra
                      return const SizedBox.shrink();
                    }

                    if (exists == true) {
                      // LOGIN mode: show Password + Forgot Password
                      return const LoginFormFields();
                    }

                    // SIGNUP mode: show Username + Password + Terms
                    return const SignupFormFields();
                  }),

                  const SizedBox(height: 36),

                  // Bottom button — Continue / Sign In / Sign Up
                  Obx(() {
                    final exists = controller.isUserExists.value;
                    final loading = controller.isLoading.value;

                    String label;
                    VoidCallback? onPressed;

                    if (exists == null) {
                      label = 'CONTINUE';
                      onPressed = loading
                          ? null
                          : () async {
                              final email = controller.loginEmailController.text
                                  .trim();
                              if (email.isEmpty) {
                                Get.snackbar(
                                  'Error',
                                  'Please enter your email',
                                  backgroundColor: Colors.redAccent,
                                  colorText: Colors.white,
                                );
                                return;
                              }
                              await controller.checkUserExists(email);
                            };
                    } else if (exists == true) {
                      label = 'SIGN IN';
                      onPressed = loading ? null : controller.userLogin;
                    } else {
                      label = 'SIGN UP';
                      onPressed = loading ? null : controller.sendMobileOtp;
                    }

                    return SizedBox(
                      height: 54,
                      child: ElevatedButton(
                        onPressed: onPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttonBgColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: loading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.textColor,
                                  ),
                                ),
                              )
                            : Text(
                                label,
                                style: const TextStyle(
                                  color: AppColors.textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                      ),
                    );
                  }),

                  // "Change email" link when in login/signup mode
                  Obx(() {
                    if (controller.isUserExists.value == null) {
                      return const SizedBox.shrink();
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: GestureDetector(
                        onTap: controller.resetAuthState,
                        child: const Text(
                          'Use a different email',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.accentBlue,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
            // Loading overlay
            LoadingOverlay(isLoading: controller.isLoading),
          ],
        ),
      ),
    );
  }
}
