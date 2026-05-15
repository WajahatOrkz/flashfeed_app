import 'package:get/get.dart';
import '../controllers/edit_profile_controller.dart';
import '../controllers/profile_controller.dart';

class UserProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProfileController>(() => UserProfileController());
    Get.lazyPut<EditProfileController>(() => EditProfileController(), fenix: true);
  }
}
