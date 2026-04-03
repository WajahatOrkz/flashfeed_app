import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/auth_controller.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_social_icon.dart';

class SignupView extends GetView<AuthController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),

              // Title
              const Text(
                'Create Account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Sign up to get started',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textColor.withOpacity(0.8),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 40),

              // Name TextField
              CustomTextField(
                controller: controller.signupNameController,
                hintText: 'Full Name',
                fieldBgColor: AppColors.fieldBgColor,
                borderColor: AppColors.borderColor,
              ),
              const SizedBox(height: 16),

              // Email TextField
              CustomTextField(
                controller: controller.signupEmailController,
                hintText: 'Email',
                fieldBgColor: AppColors.fieldBgColor,
                borderColor: AppColors.borderColor,
              ),
              const SizedBox(height: 16),

              // Password TextField
              CustomTextField(
                controller: controller.signupPasswordController,
                hintText: 'Password',
                obscureText: true,
                fieldBgColor: AppColors.fieldBgColor,
                borderColor: AppColors.borderColor,
              ),
              const SizedBox(height: 32),

              // Signup Button
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: controller.signup,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonBgColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Signup',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Login Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(
                      color: AppColors.textColor.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: controller.navigateToLogin,
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: AppColors.accentBlue,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48),

              // Social Signup Divider
              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      color: AppColors.dividerColor,
                      thickness: 1,
                      endIndent: 16,
                    ),
                  ),
                  Text(
                    'Or Signup with',
                    style: TextStyle(
                      color: AppColors.textColor.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                  const Expanded(
                    child: Divider(
                      color: AppColors.dividerColor,
                      thickness: 1,
                      indent: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Social Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialIcon(
                    icon: FontAwesomeIcons.facebook,
                    onTap: () => controller.socialSignup('Facebook'),
                    bgColor: AppColors.fieldBgColor,
                  ),
                  const SizedBox(width: 24),
                  SocialIcon(
                    icon: FontAwesomeIcons.twitter,
                    onTap: () => controller.socialSignup('Twitter'),
                    bgColor: AppColors.fieldBgColor,
                  ),
                  const SizedBox(width: 24),
                  SocialIcon(
                    icon: FontAwesomeIcons.instagram,
                    onTap: () => controller.socialSignup('Instagram'),
                    bgColor: AppColors.fieldBgColor,
                  ),
                ],
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
