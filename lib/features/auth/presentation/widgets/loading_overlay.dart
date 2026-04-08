import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';

class LoadingOverlay extends StatelessWidget {
  final RxBool isLoading;

  const LoadingOverlay({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!isLoading.value) return const SizedBox.shrink();
      return AbsorbPointer(
        absorbing: true,
        child: Container(
          color: Colors.black.withOpacity(0.3),
          child: Center(
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.fieldBgColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.textColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
