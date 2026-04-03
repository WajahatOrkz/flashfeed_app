import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/feed_controller.dart';

class FeedView extends GetView<FeedController> {
  const FeedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: const Text('FlashFeed', style: TextStyle(color: AppColors.textColor)),
        backgroundColor: AppColors.fieldBgColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Welcome to your Feed!',
          style: TextStyle(color: AppColors.textColor, fontSize: 18),
        ),
      ),
    );
  }
}
