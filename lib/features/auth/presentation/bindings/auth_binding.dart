import 'package:flashfeed_app/core/api/api_client.dart';
import 'package:flashfeed_app/repositories/auth_repo.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthRepo(apiClient: ApiClient()), permanent: true);
    Get.put<AuthController>(
      AuthController(authRepo: Get.find<AuthRepo>()),
      permanent: true,
    );
  }
}
