import 'package:flashfeed_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialIcon extends StatelessWidget {
  final FaIconData icon;
  final VoidCallback onTap;
  final Color bgColor;

  const SocialIcon({
    super.key,
    required this.icon,
    required this.onTap,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: FaIcon(
            icon,
            color: AppColors.iconDark,
            size: 24,
          ),
        ),
      ),
    );
  }
}