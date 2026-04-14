import 'package:flashfeed_app/core/routes/routes.dart';
import 'package:flashfeed_app/core/services/shared_preferences_services.dart';
import 'package:flashfeed_app/features/onboarding/data/models/onboarding_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;
  final PageController pageController = PageController();

  final List<OnboardingContent> contents = [
    OnboardingContent(
      image: 'assets/images/onb1.png',
      title: 'Track your work\nand get the result',
      description:
          'Remember to keep track of your professional accomplishments.',
      bgColor: const Color(0xFFDEDBD0),
    ),
    OnboardingContent(
      image: 'assets/images/onb2.png',
      title: 'Stay organized\nwith team',
      description:
          'But understanding the contributions our colleagues make to our teams and companies.',
      bgColor: const Color(0xFFFEE7E0),
    ),
    OnboardingContent(
      image: 'assets/images/onb3.png',
      title: 'Get notified when\nwork happens',
      description:
          'Take control of notifications, collaborate live or on your own time.',
      bgColor: const Color(0xFFE0F7EF),
    ),
  ];

  void nextPage() {
    if (currentPage.value < contents.length - 1) {
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.easeIn);
    } else {
      _finishOnboarding();
    }
  }

  void skip() {
    _finishOnboarding();
  }

  Future<void> _finishOnboarding() async {
    await SharedPreferencesService.instance.setOnboardingSeen();
    Get.offAllNamed(AppRoutes.initialAuth);
  }
}
