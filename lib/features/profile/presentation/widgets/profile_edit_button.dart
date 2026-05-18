import 'package:flashfeed_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class EditProfileButton extends StatelessWidget {
  final VoidCallback onPressed;

  const EditProfileButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.edit_outlined, size: 17),
        label: const Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          side: const BorderSide(color: AppColors.primaryColor, width: 1.5),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          backgroundColor: AppColors.primaryColor.withOpacity(0.07),
        ),
      ),
    );
  }
}
