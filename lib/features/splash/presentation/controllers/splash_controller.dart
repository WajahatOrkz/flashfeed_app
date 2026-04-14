import 'package:get/get.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/services/shared_preferences_services.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2));

    final isLoggedIn = SharedPreferencesService.instance.isLoggedIn;

    if (isLoggedIn) {
      Get.offAllNamed(AppRoutes.feed);
    } else {
      Get.offAllNamed(AppRoutes.initialAuth);
    }
  }
}
