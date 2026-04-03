import 'package:flashfeed/features/auth/presentation/widgets/custom_social_icon.dart';
import 'package:flashfeed/features/auth/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

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
              const SizedBox(height: 60),

              // Logo section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
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
              const SizedBox(height: 24),

              // Welcome Texts
              const Text(
                'Welcome to FlashFeed.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Hold your precount',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textColor.withOpacity(0.8),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 40),

              // Email TextField
              CustomTextField(
                controller: controller.loginEmailController,
                hintText: 'Email',
                fieldBgColor: AppColors.fieldBgColor,
                borderColor: AppColors.borderColor,
              ),
              const SizedBox(height: 16),

              // Password TextField
              CustomTextField(
                controller: controller.loginPasswordController,
                hintText: 'Password',
                obscureText: true,
                fieldBgColor: AppColors.fieldBgColor,
                borderColor: AppColors.borderColor,
              ),
              const SizedBox(height: 32),

              // Login Button
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: controller.login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonBgColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Signup Text
              GestureDetector(
                onTap: controller.navigateToSignup,
                child: const Text(
                  'Signup',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.accentBlue,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 48),

              // Social Login Divider
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
                    'Social Login',
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
                    onTap: () => controller.socialLogin('Facebook'),
                    bgColor: AppColors.fieldBgColor,
                  ),
                  const SizedBox(width: 24),
                  SocialIcon(
                    icon: FontAwesomeIcons.twitter,
                    onTap: () => controller.socialLogin('Twitter'),
                    bgColor: AppColors.fieldBgColor,
                  ),
                  const SizedBox(width: 24),
                  SocialIcon(
                    icon: FontAwesomeIcons.instagram,
                    onTap: () => controller.socialLogin('Instagram'),
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
