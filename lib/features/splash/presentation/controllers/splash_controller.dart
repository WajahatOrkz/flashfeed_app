import 'package:get/get.dart';
import '../../../../core/routes/routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    // Simulate loading time for splash screen
    await Future.delayed(const Duration(seconds: 2));

    // Simulate checking if user is logged in
    // Real implementation should check secure storage or SharedPreferences
    bool isLoggedIn = false;

    if (isLoggedIn) {
      // Get.offAllNamed(AppRoutes.feed); // Navigate to Feed if logged in
    } else {
      Get.offAllNamed(AppRoutes.initialAuth); // Navigate to InitialAuth if not logged in
    }
  }
}
