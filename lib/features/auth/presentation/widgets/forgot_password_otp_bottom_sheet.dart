import 'package:flashfeed_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class ForgotPasswordOtpBottomSheet extends GetView<AuthController> {
  const ForgotPasswordOtpBottomSheet({super.key});

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
      child: SingleChildScrollView(
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
              'Verify OTP',
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'OTP sent to ${controller.forgotPasswordEmailController.text.trim()}',
              style: TextStyle(
                color: AppColors.textColor.withOpacity(0.6),
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            // 4 OTP boxes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                4,
                (i) => _ForgotOtpBox(index: i),
              ),
            ),
            const SizedBox(height: 32),
            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: controller.isForgotOtpLoading.value
                      ? null
                      : controller.verifyForgotPasswordOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentBlue,
                    disabledBackgroundColor:
                        AppColors.accentBlue.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: controller.isForgotOtpLoading.value
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
                          'VERIFY',
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
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Get.back(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.textColor.withOpacity(0.6),
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// OTP box that calls [verifyForgotPasswordOtp] on the last digit.
class _ForgotOtpBox extends GetView<AuthController> {
  final int index;
  const _ForgotOtpBox({required this.index});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 64,
      child: TextField(
        controller: controller.otpControllers[index],
        focusNode: controller.otpFocusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(
          color: AppColors.textColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: AppColors.fieldBgColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                const BorderSide(color: AppColors.borderColor, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                const BorderSide(color: AppColors.borderColor, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                const BorderSide(color: AppColors.accentBlue, width: 2),
          ),
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: (val) {
          if (val.isNotEmpty) {
            if (index < 3) {
              controller.otpFocusNodes[index + 1].requestFocus();
            } else {
              controller.otpFocusNodes[index].unfocus();
              controller.verifyForgotPasswordOtp();
            }
          } else {
            if (index > 0) {
              controller.otpFocusNodes[index - 1].requestFocus();
            }
          }
        },
      ),
    );
  }
}
