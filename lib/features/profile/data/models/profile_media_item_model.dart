enum MediaType { image, video }

class ProfileMediaItem {
  final String id;
  final MediaType type;
  final String? thumbnailUrl;

  ProfileMediaItem({required this.id, required this.type, this.thumbnailUrl});
}
