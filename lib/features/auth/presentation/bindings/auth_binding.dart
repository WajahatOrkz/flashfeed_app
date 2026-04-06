import 'package:flashfeed_app/repositories/auth_repo.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthRepo());
    Get.lazyPut<AuthController>(
      () => AuthController(authRepo: Get.find<AuthRepo>()),
    );
  }
}
