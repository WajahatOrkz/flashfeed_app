import 'package:flashfeed_app/core/theme/app_colors.dart';
import 'package:flashfeed_app/features/profile/data/models/profile_media_item_model.dart';
import 'package:flutter/material.dart';

class MediaItemWidget extends StatelessWidget {
  final ProfileMediaItem item;

  const MediaItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          item.thumbnailUrl ?? 'https://picsum.photos/300/300',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (_, __, ___) => Container(
            color: AppColors.fieldBgColor,
            child: Icon(
              item.type == MediaType.video
                  ? Icons.videocam
                  : Icons.image,
              color: AppColors.iconGrey,
              size: 40,
            ),
          ),
        ),

        if (item.type == MediaType.video)
          Positioned(
            bottom: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
      ],
    );
  }
}