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
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        color: AppColors.buttonBgColor,
        border: Border(
          bottom: BorderSide(
            color: AppColors.bgColor,
            width: 2,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StatItem(count: followers.toString(), label: 'Followers'),
          Container(
            height: 40,
            width: 1,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            color: AppColors.dividerColor,
          ),
          StatItem(count: following.toString(), label: 'Following'),
        ],
      ),
    );
  }
}