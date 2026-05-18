import 'package:flashfeed_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileAppBar extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback? onMenu;

  const ProfileAppBar({super.key, this.onBack, this.onMenu});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: Colors.transparent,
      child: Row(
        children: [
          GestureDetector(
            onTap: onBack,
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.fieldBgColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.borderColor.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.textColor,
                size: 17,
              ),
            ),
          ),
          const Spacer(),
          const Text(
            'Profile',
            style: TextStyle(
              color: AppColors.textColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onMenu,
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.fieldBgColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.borderColor.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.more_horiz,
                color: AppColors.textColor,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
