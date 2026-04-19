import 'package:flashfeed_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileAppBar extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback? onMenu;

  const ProfileAppBar({
    super.key,
    this.onBack,
    this.onMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: AppColors.buttonBgColor,
      child: Row(
        children: [
          GestureDetector(
            onTap: onBack,
            child: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.textColor,
              size: 24,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onMenu,
            child: const Icon(
              Icons.more_horiz,
              color: AppColors.textColor,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}