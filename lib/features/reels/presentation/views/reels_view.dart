import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/theme/app_colors.dart';
import '../controllers/reels_controller.dart';

class ReelsView extends GetView<ReelsController> {
  const ReelsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Reels',
        style: TextStyle(color: AppColors.textColor, fontSize: 18),
      ),
    );
  }
}
