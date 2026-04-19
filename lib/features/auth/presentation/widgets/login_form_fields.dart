import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/auth_controller.dart';
import 'auth_password_field.dart';

class LoginFormFields extends GetView<AuthController> {
  const LoginFormFields({super.key});

  @override
  Widget build(BuildContext context) {
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
        AuthPasswordField(
          textController: controller.loginPasswordController,
          visible: controller.loginPasswordVisible,
        ),
        const SizedBox(height: 8),
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
      ],
    );
  }
}
