import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/auth_controller.dart';
import 'auth_password_field.dart';
import 'custom_textfield.dart';

class SignupFormFields extends GetView<AuthController> {
  const SignupFormFields({super.key});

  @override
  Widget build(BuildContext context) {
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
        AuthPasswordField(
          textController: controller.signupPasswordController,
          visible: controller.signupPasswordVisible,
        ),
        const SizedBox(height: 28),
        // Terms & Privacy checkbox
        Obx(
          () => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () =>
                    controller.termsEnabled.value =
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
                      ? const Icon(
                          Icons.check,
                          color: AppColors.bgColor,
                          size: 16,
                        )
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
                        text: 'By using our services you are agreeing to our\n',
                      ),
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
          ),
        ),
      ],
    );
  }
}
