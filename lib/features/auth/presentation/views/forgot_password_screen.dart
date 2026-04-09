import 'package:flashfeed_app/features/auth/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/auth_controller.dart';

class ForgotPasswordScreen extends GetView<AuthController> {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: PopScope(
        onPopInvokedWithResult: (didPop, _) {
          if (didPop) controller.clearForgotPasswordState();
        },
        child: Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: AppBar(
            backgroundColor: AppColors.bgColor,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.textColor,
              ),
              onPressed: () {
                controller.clearForgotPasswordState();
                Get.back();
              },
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 32),

                  // Icon
                  const Center(
                    child: Icon(
                      Icons.lock_reset_rounded,
                      color: AppColors.accentBlue,
                      size: 72,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Title
                  const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),

                  // Subtitle
                  Text(
                    'Enter your registered email. We\'ll send you an OTP to reset your password.',
                    style: TextStyle(
                      color: AppColors.textColor.withOpacity(0.6),
                      fontSize: 14,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  // Email label
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
                    controller: controller.forgotPasswordEmailController,
                    hintText: 'Enter your registered email',
                    fieldBgColor: AppColors.fieldBgColor,
                    borderColor: AppColors.borderColor,
                  ),
                  const SizedBox(height: 40),

                  // Send OTP Button
                  Obx(
                    () => SizedBox(
                      height: 54,
                      child: ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : () => controller.forgotPasswordSendOtp(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentBlue,
                          disabledBackgroundColor: AppColors.accentBlue
                              .withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: controller.isLoading.value
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.textColor,
                                  ),
                                ),
                              )
                            : const Text(
                                'SEND OTP',
                                style: TextStyle(
                                  color: AppColors.textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
