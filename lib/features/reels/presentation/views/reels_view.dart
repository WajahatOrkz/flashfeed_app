import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/reels_controller.dart';
import '../widgets/reel_item_widget.dart';

class ReelsView extends GetView<ReelsController> {
  const ReelsView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        extendBodyBehindAppBar: true,
        body: Obx(() {
          if (controller.reels.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          }

          return Stack(
            children: [
              // ── Full-screen vertical PageView ──────────────────────
              PageView.builder(
                controller: controller.pageController,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemCount: controller.reels.length,
                onPageChanged: (i) => controller.currentIndex.value = i,
                itemBuilder: (context, index) {
                  return Obx(
                    () => ReelItemWidget(
                      reel: controller.reels[index],
                      controller: controller,
                      isActive: controller.currentIndex.value == index,
                    ),
                  );
                },
              ),

              // ── Top AppBar overlay ─────────────────────────────────
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: _ReelsTopBar(controller: controller),
              ),
            ],
          );
        }),
      ),
    );
  }
}

// ── Top Bar ───────────────────────────────────────────────────────────────────
class _ReelsTopBar extends StatelessWidget {
  final ReelsController controller;

  const _ReelsTopBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        left: 16,
        right: 16,
        bottom: 12,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black.withOpacity(0.55), Colors.transparent],
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.bolt, color: AppColors.primaryColor, size: 22),
          const SizedBox(width: 6),
          const Text(
            'Reels',
            style: TextStyle(
              color: AppColors.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 0.5,
            ),
          ),
          const Spacer(),
          // Progress dots
          Obx(
            () => _ReelProgressDots(
              total: controller.reels.length,
              current: controller.currentIndex.value,
            ),
          ),
          const SizedBox(width: 12),
          // Camera icon
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.12),
              ),
              child: const Icon(
                Icons.camera_alt_outlined,
                color: AppColors.textColor,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Progress Dots ─────────────────────────────────────────────────────────────
class _ReelProgressDots extends StatelessWidget {
  final int total;
  final int current;

  const _ReelProgressDots({required this.total, required this.current});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(total, (i) {
        final isActive = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 2),
          width: isActive ? 18 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primaryColor : Colors.white38,
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}
