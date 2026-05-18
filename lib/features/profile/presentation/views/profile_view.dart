import 'package:flashfeed_app/core/theme/app_colors.dart';
import 'package:flashfeed_app/features/profile/presentation/widgets/custom_about_section.dart';
import 'package:flashfeed_app/features/profile/presentation/widgets/custom_appbar.dart';
import 'package:flashfeed_app/features/profile/presentation/widgets/custom_profile_header.dart';
import 'package:flashfeed_app/features/profile/presentation/widgets/custom_profile_media_grid.dart';
import 'package:flashfeed_app/features/profile/presentation/widgets/profile_edit_button.dart';
import 'package:flashfeed_app/features/profile/presentation/widgets/profile_stats_row.dart';
import 'package:flashfeed_app/features/feed/presentation/controllers/feed_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<UserProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor, // Deep dark matching the app
      body: SafeArea(
        child: Column(
          children: [
            // Keep AppBar pinned at the top
            ProfileAppBar(
              onBack: () => Get.find<FeedController>().onTabChanged(0),
              onMenu: () {},
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Profile Header (Avatar & Name)
                    Obx(
                      () => ProfileHeader(
                        imageUrl: controller.profileImageUrl.value,
                        name: controller.username.value,
                      ),
                    ),

                    Obx(() => AboutSection(aboutText: controller.about.value)),

                    // Stats (Followers, Following, etc.)
                    Obx(
                      () => ProfileStatsRow(
                        posts: controller.mediaItems.length,
                        followers: controller.followerCount.value,
                        following: controller.followingCount.value,
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Edit Profile Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: EditProfileButton(
                        onPressed: controller.editProfile,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Media Grid
                    ProfileMediaGrid(items: controller.mediaItems),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
