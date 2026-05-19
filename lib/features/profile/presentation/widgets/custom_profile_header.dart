import 'package:flashfeed_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String imageUrl;
  final String name;

  const ProfileHeader({super.key, required this.imageUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        // Gradient ring avatar
        Container(
          width: 108,
          height: 108,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [
                AppColors.primaryColor,
                AppColors.secondaryColor,
                Color(0xFF56CCF2),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withOpacity(0.4),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          padding: const EdgeInsets.all(3),
          child: ClipOval(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.fieldBgColor,
                child: const Icon(
                  Icons.person,
                  color: AppColors.iconGrey,
                  size: 46,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Name
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 4),
        // @username tag
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '@${name.toLowerCase().replaceAll(' ', '_')}',
            style: TextStyle(
              color: AppColors.primaryColor.withOpacity(0.9),
              fontSize: 13,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
