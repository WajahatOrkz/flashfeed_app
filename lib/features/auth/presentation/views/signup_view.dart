import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/auth_controller.dart';
import '../widgets/custom_textfield.dart';

class SignupView extends GetView<AuthController> {
  const SignupView({super.key});

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
                controller: controller.signupEmailController,
                hintText: 'Enter your email',
                fieldBgColor: AppColors.fieldBgColor,
                borderColor: AppColors.borderColor,
              ),
              const SizedBox(height: 20),

              // Username label + field
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
                    controller: controller.signupPasswordController,
                    obscureText: !controller.signupPasswordVisible.value,
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
                          controller.signupPasswordVisible.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: AppColors.iconGrey,
                        ),
                        onPressed: () {
                          controller.signupPasswordVisible.value =
                              !controller.signupPasswordVisible.value;
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Terms & Privacy Policy checkbox
              Obx(
                () => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.termsEnabled.value =
                            !controller.termsEnabled.value;
                      },
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
                              text:
                                  'By using our services you are agreeing to our\n',
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
              const SizedBox(height: 32),

              // Sign Up Button
              SizedBox(
                height: 54,
                child: ElevatedButton(
                  onPressed: () => controller.sendMobileOtp(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonBgColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Sign Up',
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
    );
  }
}
