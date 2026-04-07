import 'package:flashfeed_app/core/theme/app_colors.dart';
import 'package:flashfeed_app/features/auth/presentation/widgets/otp_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class OtpBottomSheet extends GetView<AuthController> {
  const OtpBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.bgColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.borderColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Enter OTP',
            style: TextStyle(
              color: AppColors.textColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Obx(() => Text(
                'OTP sent to ${controller.loginEmailController.text.trim()}',
                style: TextStyle(
                  color: AppColors.textColor.withOpacity(0.6),
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              )),
          const SizedBox(height: 32),
          // 6 OTP boxes
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(6, (i) => OtpBox(index: i)),
          ),
          const SizedBox(height: 32),
          Obx(() => SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: controller.isOtpLoading.value
                      ? null
                      : controller.verifyOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonBgColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: controller.isOtpLoading.value
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.textColor),
                          ),
                        )
                      : const Text(
                          'VERIFY',
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                ),
              )),
          const SizedBox(height: 16),
          TextButton(
            onPressed: controller.signup,
            child: const Text(
              'Resend OTP',
              style: TextStyle(
                color: AppColors.accentBlue,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


