import 'package:flashfeed_app/core/theme/app_colors.dart';
import 'package:flashfeed_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class OtpBox extends GetView<AuthController> {
  final int index;
  const OtpBox({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 52,
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
              controller.verifyOtp();
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