import 'package:flashfeed_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  final String aboutText;

  const AboutSection({super.key, required this.aboutText});

  @override
  Widget build(BuildContext context) {
    final trimmedText = aboutText.trim();
    if (trimmedText.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.fieldBgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.borderColor.withOpacity(0.5),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ABOUT',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w700,
                fontSize: 11,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              trimmedText,
              style: const TextStyle(
                color: AppColors.textColor,
                fontSize: 14,
                height: 1.6,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
