import 'package:flashfeed_app/core/theme/app_colors.dart';
import 'package:flashfeed_app/features/onboarding/presentation/controller/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingPage extends GetView<OnboardingController> {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor, // Background from your AppColors
      body: Obx(() {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          color: controller.contents[controller.currentPage.value].bgColor,
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    onPageChanged: (index) =>
                        controller.currentPage.value = index,
                    itemCount: controller.contents.length,
                    itemBuilder: (context, index) {
                      final item = controller.contents[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(item.image, height: 300),
                            const SizedBox(height: 40),
                            Text(
                              item.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors
                                    .iconDark, // Using your dark color for text on light bg
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              item.description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.iconDark.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Bottom Section: Indicators & Buttons
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Skip Button
                      TextButton(
                        onPressed: controller.skip,
                        child: const Text(
                          "SKIP",
                          style: TextStyle(
                            color: AppColors.iconDark,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Indicators
                      Row(
                        children: List.generate(
                          controller.contents.length,
                          (index) => Container(
                            height: 6,
                            width: controller.currentPage.value == index
                                ? 18
                                : 6,
                            margin: const EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.iconDark,
                            ),
                          ),
                        ),
                      ),

                      // Next/Start Button
                      ElevatedButton(
                        onPressed: controller.nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 15,
                          ),
                        ),
                        child: Text(
                          controller.currentPage.value ==
                                  controller.contents.length - 1
                              ? "START"
                              : "NEXT",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
