import 'package:flashfeed_app/core/api/api_client.dart';
import 'package:flashfeed_app/core/routes/routes.dart';
import 'package:flashfeed_app/core/services/shared_preferences_services.dart';
import 'package:flashfeed_app/features/profile/data/models/profile_media_item_model.dart';
import 'package:flashfeed_app/features/profile/data/repositories/profile_repo.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController {
  var followerCount = 0.obs;
  var followingCount = 0.obs;
  var mediaItems = <ProfileMediaItem>[].obs;
  var isLoading = false.obs;
  var username = ''.obs;
  var profileImageUrl = ''.obs;
  var about = ''.obs;

  late final ProfileRepo _profileRepo;

  @override
  void onInit() {
    super.onInit();
    _profileRepo = ProfileRepo(apiClient: ApiClient());
    loadProfileData();
  }

  Future<void> loadProfileData() async {
    isLoading.value = true;

    final userId = SharedPreferencesService.instance.userId ?? '';

    if (userId.isNotEmpty) {
      // Fetch name, followers, following from API
      final userProfile = await _profileRepo.getUserProfile(userId);
      final user = userProfile.data?.users.firstOrNull;
      if (user != null) {
        final name = user.name ?? '';
        if (name.isNotEmpty) username.value = name;
        followerCount.value = user.followers.length;
        followingCount.value = user.following.length;
        about.value = user.about ?? '';
      }

      // Fetch fresh signed image URL from API
      final imageUrl = await _profileRepo.getUserImage(userId);
      if (imageUrl != null && imageUrl.isNotEmpty) {
        profileImageUrl.value = imageUrl;
      }
    }

    // Sample media items (replace with real API when available)
    // mediaItems.value = List.generate(12, (index) {
    //   return ProfileMediaItem(
    //     id: 'media_$index',
    //     type: index % 3 == 1 ? MediaType.video : MediaType.image,
    //     thumbnailUrl: 'https://picsum.photos/300/300?random=${index + 20}',
    //   );
    // });

    isLoading.value = false;
  }

  void updateFollowerCount(int count) {
    followerCount.value = count;
  }

  void updateFollowingCount(int count) {
    followingCount.value = count;
  }

  Future<void> refreshProfile() async {
    await loadProfileData();
  }

  void resetProfile() {
    username.value = '';
    profileImageUrl.value = '';
    about.value = '';
    mediaItems.value = [];
  }

  void editProfile() {
    Get.toNamed(AppRoutes.editProfileRoute);
  }
}
