import 'package:flashfeed_app/core/theme/app_colors.dart';
import 'package:flashfeed_app/features/feed/data/feed_item_model.dart';
import 'package:flashfeed_app/features/feed/presentation/controllers/feed_controller.dart';
import 'package:flashfeed_app/features/feed/presentation/widgets/custom_feed_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<FeedController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(color: AppColors.primaryColor),
        );
      }

      return CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Stories Row ──────────────────────────────────────────
          SliverToBoxAdapter(child: _StoriesRow()),

          // ── Section Label ─────────────────────────────────────────
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 10),
              child: Row(
                children: [
                  Text(
                    'For You',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.auto_awesome,
                    color: AppColors.primaryColor,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),

          // ── Feed Grid ─────────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                childAspectRatio: 1,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
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
              }, childCount: controller.feedItems.length),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      );
    });
  }
}

// ── Stories Row ───────────────────────────────────────────────────────────────
class _StoriesRow extends StatelessWidget {
  _StoriesRow();

  final List<_StoryData> _stories = [
    _StoryData(name: 'Your Story', isOwn: true),
    _StoryData(name: 'alex_m', avatarSeed: 10),
    _StoryData(name: 'sara.k', avatarSeed: 20),
    _StoryData(name: 'john_d', avatarSeed: 30),
    _StoryData(name: 'mia_w', avatarSeed: 40),
    _StoryData(name: 'ryan_c', avatarSeed: 50),
    _StoryData(name: 'luna.s', avatarSeed: 60),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(top: 8),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        physics: const BouncingScrollPhysics(),
        itemCount: _stories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final story = _stories[index];
          return _StoryItem(story: story);
        },
      ),
    );
  }
}

class _StoryData {
  final String name;
  final bool isOwn;
  final int? avatarSeed;
  _StoryData({required this.name, this.isOwn = false, this.avatarSeed});
}

class _StoryItem extends StatelessWidget {
  final _StoryData story;
  const _StoryItem({required this.story});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 62,
          height: 62,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: story.isOwn
                ? null
                : const LinearGradient(
                    colors: [Color(0xFF4ACEE0), Color(0xFF8134AF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            border: story.isOwn
                ? Border.all(color: AppColors.fieldBgColor, width: 2)
                : null,
          ),
          padding: const EdgeInsets.all(2.5),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.bgColor,
            ),
            padding: const EdgeInsets.all(2),
            child: ClipOval(
              child: story.isOwn
                  ? Container(
                      color: AppColors.fieldBgColor,
                      child: const Icon(
                        Icons.add,
                        color: AppColors.primaryColor,
                        size: 26,
                      ),
                    )
                  : Image.network(
                      'https://picsum.photos/100/100?random=${story.avatarSeed}',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: AppColors.fieldBgColor,
                        child: const Icon(
                          Icons.person,
                          color: AppColors.iconGrey,
                        ),
                      ),
                    ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 62,
          child: Text(
            story.isOwn ? 'You' : story.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: story.isOwn ? AppColors.primaryColor : AppColors.iconGrey,
              fontSize: 11,
              fontWeight: story.isOwn ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
