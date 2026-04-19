import 'package:flashfeed_app/features/profile/data/models/profile_media_item_model.dart';
import 'package:flashfeed_app/features/profile/presentation/widgets/custom_media_item.dart';
import 'package:flutter/material.dart';

class ProfileMediaGrid extends StatelessWidget {
  final List<ProfileMediaItem> items;

  const ProfileMediaGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(2),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: items.length,
      itemBuilder: (_, index) {
        return MediaItemWidget(item: items[index]);
      },
    );
  }
}
