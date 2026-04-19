import 'package:flashfeed_app/features/auth/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 60),

                // Logo section
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.bolt,
                      color: AppColors.lightningBlue,
                      size: 80,
                    ),
                    const SizedBox(width: 4),
                    const Icon(
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

                // Email label + field
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
                const SizedBox(height: 20),

                // Password label + field with eye toggle
                const Text(
                  'Password',
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Obx(
                  () => Container(
                    decoration: BoxDecoration(
                      color: AppColors.fieldBgColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.borderColor,
                        width: 1.5,
                      ),
                    ),
                    child: TextField(
                      controller: controller.loginPasswordController,
                      obscureText: !controller.loginPasswordVisible.value,
                      style: const TextStyle(
                        color: AppColors.textColor,
                        fontSize: 16,
                      ),
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
                            controller.loginPasswordVisible.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.iconGrey,
                          ),
                          onPressed: () {
                            controller.loginPasswordVisible.value =
                                !controller.loginPasswordVisible.value;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.forgotPasswordRoute),
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
                const SizedBox(height: 36),

                // Sign In Button
                SizedBox(
                  height: 54,
                  child: ElevatedButton(
                    onPressed: controller.userLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonBgColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
