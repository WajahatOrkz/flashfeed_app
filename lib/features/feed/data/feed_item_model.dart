// Feed Item Model
enum FeedItemType {
  image,
  video,
  carousel,
  placeholder,
  empty,
}

class FeedItem {
  final String id;
  final FeedItemType type;
  final String? imageUrl;
  final bool isSelected;
  final bool hasOverlay;
  final bool isBlue;

  FeedItem({
    required this.id,
    required this.type,
    this.imageUrl,
    this.isSelected = false,
    this.hasOverlay = false,
    this.isBlue = false,
  });
}