import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/auth_controller.dart';
import '../widgets/custom_textfield.dart';

class InitialAuthView extends GetView<AuthController> {
  const InitialAuthView({super.key});

  Widget _passwordField({
    required TextEditingController textController,
    required RxBool visible,
  }) {
    return Obx(() => Container(
          decoration: BoxDecoration(
            color: AppColors.fieldBgColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.borderColor, width: 1.5),
          ),
          child: TextField(
            controller: textController,
            obscureText: !visible.value,
            style: const TextStyle(color: AppColors.textColor, fontSize: 16),
            decoration: InputDecoration(
              hintText: 'Type your password',
              hintStyle: TextStyle(
                color: AppColors.textColor.withOpacity(0.4),
                fontSize: 16,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  visible.value
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.iconGrey,
                ),
                onPressed: () => visible.value = !visible.value,
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
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
                  Icon(Icons.bolt, color: AppColors.lightningBlue, size: 80),
                  SizedBox(width: 4),
                  Icon(Icons.camera_alt_rounded,
                      color: AppColors.iconGrey, size: 60),
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
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Password',
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _passwordField(
                        textController: controller.loginPasswordController,
                        visible: controller.loginPasswordVisible,
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Forgot Password',
                            style: TextStyle(
                              color: AppColors.accentBlue,
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.accentBlue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }

                // SIGNUP mode: show Username + Password + Terms
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Username',
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CustomTextField(
                      controller: controller.signupNameController,
                      hintText: 'Enter your username',
                      fieldBgColor: AppColors.fieldBgColor,
                      borderColor: AppColors.borderColor,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Password',
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _passwordField(
                      textController: controller.signupPasswordController,
                      visible: controller.signupPasswordVisible,
                    ),
                    const SizedBox(height: 28),
                    // Terms & Privacy checkbox
                    Obx(() => Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () => controller.termsEnabled.value =
                                  !controller.termsEnabled.value,
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: controller.termsEnabled.value
                                      ? AppColors.accentBlue
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: AppColors.accentBlue,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: controller.termsEnabled.value
                                    ? const Icon(Icons.check,
                                        color: AppColors.bgColor, size: 16)
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: AppColors.textColor.withOpacity(0.8),
                                    fontSize: 14,
                                    height: 1.4,
                                  ),
                                  children: const [
                                    TextSpan(
                                        text:
                                            'By using our services you are agreeing to our\n'),
                                    TextSpan(
                                      text: 'Terms',
                                      style: TextStyle(
                                        color: AppColors.accentBlue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextSpan(text: ' and '),
                                    TextSpan(
                                      text: 'Privacy Policy',
                                      style: TextStyle(
                                        color: AppColors.accentBlue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                );
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
                          final email =
                              controller.loginEmailController.text.trim();
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
                  onPressed = loading ? null : controller.login;
                } else {
                  label = 'SIGN UP';
                  onPressed = loading ? null : controller.signup;
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
                                  AppColors.textColor),
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
    );
  }
}

