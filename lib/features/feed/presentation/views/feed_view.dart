import 'package:flashfeed_app/features/feed/presentation/widgets/custom_home.dart';
import 'package:flashfeed_app/features/profile/presentation/views/profile_view.dart';
import 'package:flashfeed_app/features/reels/presentation/views/reels_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/feed_controller.dart';

class FeedView extends GetView<FeedController> {
  const FeedView({super.key});

  static const List<Widget> _pages = [HomeView(), ReelsView(), ProfileView()];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.bgColor,
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   title: const Text(
        //     'FlashFeed',
        //     style: TextStyle(color: AppColors.textColor),
        //   ),
        //   backgroundColor: AppColors.primaryColor,
        //   elevation: 0,
        //   centerTitle: true,
        //   actions: [
        //     Get.find<AuthController>().isLogoutLoading.value
        //         ? const Padding(
        //             padding: EdgeInsets.all(14),
        //             child: SizedBox(
        //               width: 20,
        //               height: 20,
        //               child: CircularProgressIndicator(
        //                 strokeWidth: 2,
        //                 valueColor: AlwaysStoppedAnimation<Color>(
        //                   AppColors.textColor,
        //                 ),
        //               ),
        //             ),
        //           )
        //         : IconButton(
        //             icon: const Icon(Icons.logout, color: AppColors.textColor),
        //             tooltip: 'Logout',
        //             onPressed: Get.find<AuthController>().logout,
        //           ),
        //   ],
        // ),
        body: _pages[controller.selectedIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.onTabChanged,
          backgroundColor: AppColors.primaryColor,
          selectedItemColor: AppColors.textColor,
          unselectedItemColor: AppColors.iconDark,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.play_circle_outline),
              activeIcon: Icon(Icons.play_circle),
              label: 'Reels',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

// class _HomeTab extends StatelessWidget {
//   const _HomeTab();

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         'Welcome to your Feed!',
//         style: TextStyle(color: AppColors.textColor, fontSize: 18),
//       ),
//     );
//   }
// }
