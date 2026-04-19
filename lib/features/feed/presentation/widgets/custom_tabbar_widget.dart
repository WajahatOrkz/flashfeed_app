import 'package:flashfeed_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTabBar extends StatelessWidget {
  final RxInt selectedIndex;
  final Function(int) onTabChange;

  const CustomTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.dividerColor,
                width: 0.5,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTabIcon(Icons.grid_on, 0),
              _divider(),
              _buildTabIcon(Icons.video_library_outlined, 1),
              _divider(),
              _buildTabIcon(Icons.person_pin_outlined, 2),
            ],
          ),
        ));
  }

  Widget _divider() {
    return Container(
      height: 24,
      width: 1,
      color: AppColors.dividerColor,
    );
  }

  Widget _buildTabIcon(IconData icon, int index) {
    final isActive = selectedIndex.value == index;

    return GestureDetector(
      onTap: () => onTabChange(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? AppColors.primaryColor : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Icon(
          icon,
          color: isActive ? AppColors.primaryColor : AppColors.iconGrey,
          size: 26,
        ),
      ),
    );
  }
}