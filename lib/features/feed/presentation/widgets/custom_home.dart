import 'package:flashfeed_app/core/theme/app_colors.dart';
import 'package:flashfeed_app/features/feed/data/feed_item_model.dart';
import 'package:flashfeed_app/features/feed/presentation/controllers/feed_controller.dart';
import 'package:flashfeed_app/features/feed/presentation/widgets/custom_feed_grid_item.dart';
import 'package:flashfeed_app/features/feed/presentation/widgets/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<FeedController> {
  const HomeView();

  @override
  Widget build(BuildContext contex) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomHeader(),
            SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  );
                }

                return GridView.builder(
                  itemCount: controller.feedItems.length,
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final item = controller.feedItems[index];
                    return FeedGridItem(
                      item: item,
                      onTap: () {
                        if (item.type != FeedItemType.empty &&
                            item.type != FeedItemType.placeholder) {
                          controller.toggleSelection(item.id);
                        }
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
