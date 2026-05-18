import 'package:flashfeed_app/core/theme/app_colors.dart';
import 'package:flashfeed_app/features/profile/presentation/widgets/custom_stats.dart';
import 'package:flutter/material.dart';

class ProfileStatsRow extends StatelessWidget {
  final int followers;
  final int following;
  final int posts;

  const ProfileStatsRow({
    super.key,
    required this.followers,
    required this.following,
    this.posts = 0,
  });

  String _fmt(int n) {
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
    return n.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.borderColor.withOpacity(0.25),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          StatItem(count: _fmt(posts), label: 'Posts'),
          Container(height: 36, width: 1, color: AppColors.dividerColor),
          StatItem(count: _fmt(followers), label: 'Followers'),
          Container(height: 36, width: 1, color: AppColors.dividerColor),
          StatItem(count: _fmt(following), label: 'Following'),
        ],
      ),
    );
  }
}
