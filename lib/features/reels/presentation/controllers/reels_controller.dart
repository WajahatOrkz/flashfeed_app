import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/reel_model.dart';

class ReelsController extends GetxController {
  final RxList<ReelModel> reels = <ReelModel>[].obs;
  final RxInt currentIndex = 0.obs;

  final PageController pageController = PageController();

  @override
  void onInit() {
    super.onInit();
    _loadMockReels();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void _loadMockReels() {
    reels.assignAll([
      ReelModel(
        id: '1',
        username: 'Alex Morgan',
        userHandle: '@alex_morgan',
        description:
            'Golden hour vibes ✨ Nothing beats the sunset at the beach 🌊 #sunset #vibes #travel',
        musicName: 'Blinding Lights',
        musicArtist: 'The Weeknd',
        likesCount: 142300,
        commentsCount: 2841,
        sharesCount: 5622,
        bookmarksCount: 9100,
        gradientColors: [const Color(0xFFFF6B6B), const Color(0xFFFFE66D)],
        avatarSeed: 10,
      ),
      ReelModel(
        id: '2',
        username: 'Sara Kim',
        userHandle: '@sara.kim',
        description:
            'Morning routine that changed my life 🌿 Try this for 7 days and thank me later #wellness #morning',
        musicName: 'Stay',
        musicArtist: 'Justin Bieber',
        likesCount: 87400,
        commentsCount: 1230,
        sharesCount: 3100,
        bookmarksCount: 12500,
        gradientColors: [const Color(0xFF4ACEE0), const Color(0xFF2D6A4F)],
        avatarSeed: 20,
        isFollowing: true,
      ),
      ReelModel(
        id: '3',
        username: 'John Doe',
        userHandle: '@john_doe',
        description:
            'POV: You just discovered the best coffee spot in the city ☕ Drop a ❤️ if you love coffee!',
        musicName: 'As It Was',
        musicArtist: 'Harry Styles',
        likesCount: 234100,
        commentsCount: 4520,
        sharesCount: 7800,
        bookmarksCount: 18300,
        gradientColors: [const Color(0xFF6C3483), const Color(0xFF1A5276)],
        avatarSeed: 30,
      ),
      ReelModel(
        id: '4',
        username: 'Mia Wilson',
        userHandle: '@mia_w',
        description:
            'Dance challenge 💃 Tag someone who needs to try this! #dance #challenge #fun',
        musicName: 'Levitating',
        musicArtist: 'Dua Lipa',
        likesCount: 512000,
        commentsCount: 8900,
        sharesCount: 21000,
        bookmarksCount: 33000,
        gradientColors: [const Color(0xFFE91E8C), const Color(0xFF3F0E7C)],
        avatarSeed: 40,
        isLiked: true,
        isFollowing: true,
      ),
      ReelModel(
        id: '5',
        username: 'Ryan Chen',
        userHandle: '@ryan_c',
        description:
            'Best street food tour 🍜 This city has amazing hidden gems you NEED to visit #foodie #travel',
        musicName: 'Shape of You',
        musicArtist: 'Ed Sheeran',
        likesCount: 98700,
        commentsCount: 3210,
        sharesCount: 4400,
        bookmarksCount: 7600,
        gradientColors: [const Color(0xFFF57C00), const Color(0xFF880E4F)],
        avatarSeed: 50,
      ),
      ReelModel(
        id: '6',
        username: 'Luna Starr',
        userHandle: '@luna.s',
        description:
            'Night sky photography tips 🌌 You don\'t need expensive gear #photography #stars #night',
        musicName: 'Starboy',
        musicArtist: 'The Weeknd',
        likesCount: 176500,
        commentsCount: 2980,
        sharesCount: 6700,
        bookmarksCount: 22100,
        gradientColors: [const Color(0xFF1A237E), const Color(0xFF4A148C)],
        avatarSeed: 60,
      ),
    ]);
  }

  void toggleLike(String reelId) {
    final index = reels.indexWhere((r) => r.id == reelId);
    if (index == -1) return;
    final reel = reels[index];
    reels[index] = reel.copyWith(
      isLiked: !reel.isLiked,
      likesCount: reel.isLiked ? reel.likesCount - 1 : reel.likesCount + 1,
    );
  }

  void toggleBookmark(String reelId) {
    final index = reels.indexWhere((r) => r.id == reelId);
    if (index == -1) return;
    final reel = reels[index];
    reels[index] = reel.copyWith(
      isBookmarked: !reel.isBookmarked,
      bookmarksCount: reel.isBookmarked
          ? reel.bookmarksCount - 1
          : reel.bookmarksCount + 1,
    );
  }

  void toggleFollow(String reelId) {
    final index = reels.indexWhere((r) => r.id == reelId);
    if (index == -1) return;
    final reel = reels[index];
    reels[index] = reel.copyWith(isFollowing: !reel.isFollowing);
  }

  String formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }
}
