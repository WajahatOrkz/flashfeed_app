import 'package:flashfeed_app/core/theme/app_colors.dart';
import 'package:flashfeed_app/core/routes/routes.dart';
import 'package:flashfeed_app/features/profile/data/models/profile_media_item_model.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController {
  var followerCount = 32.obs;
  var followingCount = 27.obs;
  var mediaItems = <ProfileMediaItem>[].obs;
  var isLoading = false.obs;
  var username = 'User'.obs;
  var profileImageUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfileData();
  }

  void loadProfileData() {
    isLoading.value = true;

    // Simulate loading profile data
    username.value = 'Bloomville';
    profileImageUrl.value = 'https://picsum.photos/200/200?random=profile';

    // Generate sample media items
    mediaItems.value = List.generate(12, (index) {
      return ProfileMediaItem(
        id: 'media_$index',
        type: index % 3 == 1 ? MediaType.video : MediaType.image,
        thumbnailUrl: 'https://picsum.photos/300/300?random=${index + 20}',
      );
    });

    isLoading.value = false;
  }

  void updateFollowerCount(int count) {
    followerCount.value = count;
  }

  void updateFollowingCount(int count) {
    followingCount.value = count;
  }

  void refreshProfile() {
    loadProfileData();
  }

  void editProfile() {
    Get.toNamed(AppRoutes.editProfileRoute);
  }
}
