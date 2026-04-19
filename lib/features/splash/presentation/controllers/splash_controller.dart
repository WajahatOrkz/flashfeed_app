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

    final prefs = SharedPreferencesService.instance;

    if (prefs.isLoggedIn) {
      Get.offAllNamed(AppRoutes.feedRoute);
    } else if (!prefs.hasSeenOnboarding) {
      Get.offAllNamed(AppRoutes.onboardingRoute);
    } else {
      Get.offAllNamed(AppRoutes.initialAuthRoute);
    }
  }
}
