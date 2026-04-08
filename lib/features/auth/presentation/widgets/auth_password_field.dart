import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';

class AuthPasswordField extends StatelessWidget {
  final TextEditingController textController;
  final RxBool visible;

  const AuthPasswordField({
    super.key,
    required this.textController,
    required this.visible,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: AppColors.fieldBgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.borderColor, width: 1.5),
        ),
        child: TextField(
          controller: textController,
          obscureText: !visible.value,
          style: const TextStyle(color: AppColors.textColor, fontSize: 16),
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
                visible.value
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.iconGrey,
              ),
              onPressed: () => visible.value = !visible.value,
            ),
          ),
        ),
      ),
    );
  }
}
