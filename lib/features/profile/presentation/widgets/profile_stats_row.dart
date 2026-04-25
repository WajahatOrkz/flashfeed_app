import 'package:flashfeed_app/core/theme/app_colors.dart';
import 'package:flashfeed_app/features/profile/presentation/widgets/custom_stats.dart';
import 'package:flutter/material.dart';

class ProfileStatsRow extends StatelessWidget {
  final int followers;
  final int following;

  const ProfileStatsRow({
    super.key,
    required this.followers,
    required this.following,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.fieldBgColor, // Use a slightly lighter dark color
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          StatItem(count: followers.toString(), label: 'Followers'),
          Container(height: 40, width: 1, color: AppColors.dividerColor),
          StatItem(count: following.toString(), label: 'Following'),
        ],
      ),
    );
  }
}
