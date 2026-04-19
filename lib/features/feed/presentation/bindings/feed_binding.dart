import 'package:flashfeed_app/core/api/api_client.dart';
import 'package:flashfeed_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flashfeed_app/features/profile/presentation/controllers/profile_controller.dart';
import 'package:flashfeed_app/features/reels/presentation/controllers/reels_controller.dart';
import 'package:flashfeed_app/repositories/auth_repo.dart';
import 'package:get/get.dart';
import '../controllers/feed_controller.dart';

class FeedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedController>(() => FeedController());
    Get.lazyPut<ReelsController>(() => ReelsController());
    Get.lazyPut<UserProfileController>(() => UserProfileController());

    if (!Get.isRegistered<AuthRepo>()) {
      Get.put(AuthRepo(apiClient: ApiClient()), permanent: true);
    }
    if (!Get.isRegistered<AuthController>()) {
      Get.put<AuthController>(
        AuthController(authRepo: Get.find<AuthRepo>()),
        permanent: true,
      );
    }
  }
}
