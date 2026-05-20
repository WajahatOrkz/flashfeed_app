import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/reel_model.dart';
import '../controllers/reels_controller.dart';

class ReelBottomInfo extends StatelessWidget {
  final ReelModel reel;
  final ReelsController controller;

  const ReelBottomInfo({
    super.key,
    required this.reel,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 80, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // User row
          Row(
            children: [
              // Avatar
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.textColor, width: 2),
                  gradient: LinearGradient(
                    colors: reel.gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Text(
                    reel.username[0].toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Username
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reel.username,
                      style: const TextStyle(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        shadows: [Shadow(color: Colors.black54, blurRadius: 6)],
                      ),
                    ),
                    Text(
                      reel.userHandle,
                      style: TextStyle(
                        color: AppColors.textColor.withOpacity(0.7),
                        fontSize: 12,
                        shadows: const [
                          Shadow(color: Colors.black54, blurRadius: 4),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Follow button
              GestureDetector(
                onTap: () => controller.toggleFollow(reel.id),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: reel.isFollowing
                        ? Colors.white.withOpacity(0.15)
                        : AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: reel.isFollowing
                          ? Colors.white38
                          : AppColors.primaryColor,
                    ),
                  ),
                  child: Text(
                    reel.isFollowing ? 'Following' : 'Follow',
                    style: TextStyle(
                      color: reel.isFollowing
                          ? AppColors.textColor
                          : AppColors.bgColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Description
          _ExpandableDescription(text: reel.description),
          const SizedBox(height: 10),
          // Music ticker
          _MusicTicker(
            musicName: reel.musicName,
            musicArtist: reel.musicArtist,
          ),
        ],
      ),
    );
  }
}

// ── Expandable Description ────────────────────────────────────────────────────
class _ExpandableDescription extends StatefulWidget {
  final String text;
  const _ExpandableDescription({required this.text});

  @override
  State<_ExpandableDescription> createState() =>
      _ExpandableDescriptionState();
}

class _ExpandableDescriptionState extends State<_ExpandableDescription> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: AnimatedCrossFade(
        firstChild: Text(
          widget.text,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppColors.textColor,
            fontSize: 13,
            height: 1.5,
            shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
          ),
        ),
        secondChild: Text(
          widget.text,
          style: const TextStyle(
            color: AppColors.textColor,
            fontSize: 13,
            height: 1.5,
            shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
          ),
        ),
        crossFadeState:
            _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 200),
      ),
    );
  }
}

// ── Animated Music Ticker ─────────────────────────────────────────────────────
class _MusicTicker extends StatefulWidget {
  final String musicName;
  final String musicArtist;

  const _MusicTicker({required this.musicName, required this.musicArtist});

  @override
  State<_MusicTicker> createState() => _MusicTickerState();
}

class _MusicTickerState extends State<_MusicTicker>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotateController;

  @override
  void initState() {
    super.initState();
    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RotationTransition(
          turns: _rotateController,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.fieldBgColor,
              border: Border.all(color: Colors.white24),
            ),
            child: const Icon(
              Icons.music_note_rounded,
              color: AppColors.primaryColor,
              size: 16,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '${widget.musicName} · ${widget.musicArtist}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textColor,
              fontSize: 12,
              shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
            ),
          ),
        ),
      ],
    );
  }
}
