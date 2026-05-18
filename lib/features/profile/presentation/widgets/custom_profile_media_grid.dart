import 'package:flashfeed_app/core/theme/app_colors.dart';
import 'package:flashfeed_app/features/profile/data/models/profile_media_item_model.dart';
import 'package:flashfeed_app/features/profile/presentation/widgets/custom_media_item.dart';
import 'package:flutter/material.dart';

class ProfileMediaGrid extends StatelessWidget {
  final List<ProfileMediaItem> items;

  const ProfileMediaGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Section header
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 10),
          child: Row(
            children: [
              const Icon(Icons.grid_on_rounded, color: Colors.white, size: 19),
              const SizedBox(width: 8),
              const Text(
                'POSTS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.6,
                ),
              ),
              const Spacer(),
              if (items.isNotEmpty)
                Text(
                  '${items.length}',
                  style: const TextStyle(
                    color: AppColors.iconGrey,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        ),
        Container(height: 1, color: Colors.white.withOpacity(0.08)),
        if (items.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 52),
            child: Column(
              children: [
                Icon(
                  Icons.photo_library_outlined,
                  color: AppColors.iconGrey.withOpacity(0.45),
                  size: 54,
                ),
                const SizedBox(height: 14),
                Text(
                  'No posts yet',
                  style: TextStyle(
                    color: AppColors.iconGrey.withOpacity(0.65),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(2),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemCount: items.length,
            itemBuilder: (_, index) => MediaItemWidget(item: items[index]),
          ),
      ],
    );
  }
}
