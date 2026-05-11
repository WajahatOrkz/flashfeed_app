import 'package:flashfeed_app/core/theme/app_colors.dart';
import 'package:flashfeed_app/features/feed/data/feed_item_model.dart';
import 'package:flashfeed_app/features/feed/presentation/widgets/custom_three_lines_painter.dart';
import 'package:flutter/material.dart';

class FeedGridItem extends StatelessWidget {
  final FeedItem item;
  final Function() onTap;

  const FeedGridItem({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background content
            _buildItemContent(),

            // Dark gradient overlay for non-empty items
            if (item.type != FeedItemType.empty &&
                item.type != FeedItemType.placeholder)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 32,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.55),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

            // Top-left: selected check or carousel icon
            if (item.isSelected || item.type == FeedItemType.carousel)
              _topLeftIcon(),

            // Top-right: blocked indicator
            if (item.hasOverlay && item.type == FeedItemType.video)
              _topRightBlock(),

            // Bottom-left: video/carousel play icon
            if (item.type == FeedItemType.video ||
                item.type == FeedItemType.carousel)
              _bottomPlayIcon(),
          ],
        ),
      ),
    );
  }

  Widget _buildItemContent() {
    if (item.type == FeedItemType.empty) {
      return Container(
        color: AppColors.fieldBgColor,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.image_not_supported_outlined,
                color: AppColors.iconGrey.withOpacity(0.4),
                size: 22,
              ),
              const SizedBox(height: 4),
              Text(
                'No Media',
                style: TextStyle(
                  color: AppColors.iconGrey.withOpacity(0.4),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (item.isBlue) {
      return Container(
        color: AppColors.primaryColor.withOpacity(0.15),
        child: Center(
          child: CustomPaint(
            size: const Size(40, 40),
            painter: ThreeLinesPainter(),
          ),
        ),
      );
    }

    return Image.network(
      item.imageUrl ?? 'https://picsum.photos/300/300',
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: AppColors.fieldBgColor,
          child: const Center(
            child: SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        );
      },
      errorBuilder: (_, __, ___) => Container(
        color: AppColors.fieldBgColor,
        child: const Icon(
          Icons.broken_image_outlined,
          color: AppColors.iconGrey,
          size: 24,
        ),
      ),
    );
  }

  Widget _topLeftIcon() {
    return Positioned(
      top: 6,
      left: 6,
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: item.isSelected
              ? AppColors.primaryColor.withOpacity(0.9)
              : Colors.black54,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(
          item.isSelected
              ? Icons.check_circle_rounded
              : Icons.collections_outlined,
          color: Colors.white,
          size: 14,
        ),
      ),
    );
  }

  Widget _topRightBlock() {
    return Positioned(
      top: 6,
      right: 6,
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: AppColors.errorRed.withOpacity(0.85),
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Icon(Icons.block_rounded, color: Colors.white, size: 14),
      ),
    );
  }

  Widget _bottomPlayIcon() {
    return Positioned(
      bottom: 6,
      left: 6,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(
              item.type == FeedItemType.carousel
                  ? Icons.collections_rounded
                  : Icons.play_arrow_rounded,
              color: Colors.white,
              size: 14,
            ),
          ),
        ],
      ),
    );
  }
}
