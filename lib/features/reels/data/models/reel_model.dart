import 'package:flutter/material.dart';

class ReelModel {
  final String id;
  final String username;
  final String userHandle;
  final String description;
  final String musicName;
  final String musicArtist;
  final int likesCount;
  final int commentsCount;
  final int sharesCount;
  final int bookmarksCount;
  final List<Color> gradientColors;
  final bool isLiked;
  final bool isBookmarked;
  final bool isFollowing;
  final int avatarSeed;

  const ReelModel({
    required this.id,
    required this.username,
    required this.userHandle,
    required this.description,
    required this.musicName,
    required this.musicArtist,
    required this.likesCount,
    required this.commentsCount,
    required this.sharesCount,
    required this.bookmarksCount,
    required this.gradientColors,
    this.isLiked = false,
    this.isBookmarked = false,
    this.isFollowing = false,
    required this.avatarSeed,
  });

  ReelModel copyWith({
    bool? isLiked,
    bool? isBookmarked,
    bool? isFollowing,
    int? likesCount,
    int? bookmarksCount,
  }) {
    return ReelModel(
      id: id,
      username: username,
      userHandle: userHandle,
      description: description,
      musicName: musicName,
      musicArtist: musicArtist,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount,
      sharesCount: sharesCount,
      bookmarksCount: bookmarksCount ?? this.bookmarksCount,
      gradientColors: gradientColors,
      isLiked: isLiked ?? this.isLiked,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      isFollowing: isFollowing ?? this.isFollowing,
      avatarSeed: avatarSeed,
    );
  }
}
