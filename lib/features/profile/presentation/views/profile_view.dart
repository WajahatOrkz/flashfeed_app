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
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ProfileAppBar(
            onBack: () => Get.find<FeedController>().onTabChanged(0),
            onMenu: () {},
          ),

            Obx(
              () => ProfileHeader(imageUrl: controller.profileImageUrl.value),
            ),

            Obx(
              () => ProfileStatsRow(
                followers: controller.followerCount.value,
                following: controller.followingCount.value,
              ),
            ),

            EditProfileButton(onPressed: controller.editProfile),

            ProfileMediaGrid(items: controller.mediaItems),
          ],
        ),
      ),
    );
  }
}
