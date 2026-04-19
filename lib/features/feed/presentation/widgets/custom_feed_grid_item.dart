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
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: item.isBlue
                  ? AppColors.primaryColor
                  : AppColors.fieldBgColor,
            ),
            child: _buildItemContent(),
          ),

          if (item.isSelected || item.type == FeedItemType.carousel)
            _topLeftIcon(),

          if (item.hasOverlay && item.type == FeedItemType.video)
            _topRightBlock(),

          if (item.type == FeedItemType.video ||
              item.type == FeedItemType.carousel)
            _bottomPlayIcon(),
        ],
      ),
    );
  }

  Widget _buildItemContent() {
    if (item.type == FeedItemType.empty) {
      return Center(
        child: Text(
          'No Media',
          style: TextStyle(
            color: AppColors.iconGrey.withOpacity(0.5),
            fontSize: 12,
          ),
        ),
      );
    }

    if (item.isBlue) {
      return Center(
        child: CustomPaint(size: Size(50, 50), painter: ThreeLinesPainter()),
      );
    }

    return Image.network(
      item.imageUrl ?? 'https://picsum.photos/300/300',
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }

  Widget _topLeftIcon() {
    return Positioned(
      top: 8,
      left: 8,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: item.isSelected
              ? AppColors.successGreen.withOpacity(0.9)
              : AppColors.buttonBgColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(
          item.isSelected ? Icons.check_circle : Icons.copy,
          color: Colors.white,
          size: 16,
        ),
      ),
    );
  }

  Widget _topRightBlock() {
    return Positioned(
      top: 8,
      right: 8,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.errorRed.withOpacity(0.9),
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Icon(Icons.block, color: Colors.white, size: 16),
      ),
    );
  }

  Widget _bottomPlayIcon() {
    return Positioned(
      bottom: 8,
      left: 8,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Icon(Icons.play_arrow, color: Colors.white, size: 20),
      ),
    );
  }
}
