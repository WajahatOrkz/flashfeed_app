import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/reel_model.dart';
import '../controllers/reels_controller.dart';
import 'reel_action_button.dart';
import 'reel_bottom_info.dart';

class ReelItemWidget extends StatefulWidget {
  final ReelModel reel;
  final ReelsController controller;
  final bool isActive;

  const ReelItemWidget({
    super.key,
    required this.reel,
    required this.controller,
    required this.isActive,
  });

  @override
  State<ReelItemWidget> createState() => _ReelItemWidgetState();
}

class _ReelItemWidgetState extends State<ReelItemWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _doubleTapController;
  late Animation<double> _heartScaleAnim;
  late Animation<double> _heartOpacityAnim;
  bool _showHeart = false;

  @override
  void initState() {
    super.initState();
    _doubleTapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _heartScaleAnim = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.3, end: 1.4), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.4, end: 1.0), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 30),
    ]).animate(CurvedAnimation(
      parent: _doubleTapController,
      curve: Curves.easeOut,
    ));
    _heartOpacityAnim = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 30),
    ]).animate(_doubleTapController);
    _doubleTapController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _showHeart = false);
      }
    });
  }

  @override
  void dispose() {
    _doubleTapController.dispose();
    super.dispose();
  }

  void _onDoubleTap() {
    if (!widget.reel.isLiked) {
      widget.controller.toggleLike(widget.reel.id);
    }
    setState(() => _showHeart = true);
    _doubleTapController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onDoubleTap: _onDoubleTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ── Background video placeholder ───────────────────────────
          _ReelBackground(gradientColors: widget.reel.gradientColors),

          // ── Dark gradient overlay ──────────────────────────────────
          const _GradientOverlay(),

          // ── Double-tap heart animation ─────────────────────────────
          if (_showHeart)
            Center(
              child: AnimatedBuilder(
                animation: _doubleTapController,
                builder: (_, __) => Opacity(
                  opacity: _heartOpacityAnim.value,
                  child: Transform.scale(
                    scale: _heartScaleAnim.value,
                    child: const Icon(
                      Icons.favorite_rounded,
                      color: Colors.white,
                      size: 100,
                      shadows: [
                        Shadow(color: Colors.black38, blurRadius: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // ── Right-side action buttons ──────────────────────────────
          Positioned(
            right: 12,
            bottom: 100,
            child: Obx(() {
              final currentReel = widget.controller.reels
                  .firstWhere((r) => r.id == widget.reel.id);
              return _SideActions(
                reel: currentReel,
                controller: widget.controller,
              );
            }),
          ),

          // ── Bottom info ────────────────────────────────────────────
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Obx(() {
              final currentReel = widget.controller.reels
                  .firstWhere((r) => r.id == widget.reel.id);
              return ReelBottomInfo(
                reel: currentReel,
                controller: widget.controller,
              );
            }),
          ),
        ],
      ),
    );
  }
}

// ── Background ─────────────────────────────────────────────────────────────────
class _ReelBackground extends StatelessWidget {
  final List<Color> gradientColors;

  const _ReelBackground({required this.gradientColors});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          // Grid overlay texture
          Positioned.fill(
            child: CustomPaint(painter: _GridPainter()),
          ),
          // Play icon in center (simulates video)
          Center(
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.35),
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
                color: Colors.white70,
                size: 44,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.04)
      ..strokeWidth = 1;
    const step = 40.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter _) => false;
}

// ── Gradient Overlay ──────────────────────────────────────────────────────────
class _GradientOverlay extends StatelessWidget {
  const _GradientOverlay();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.3),
            Colors.transparent,
            Colors.transparent,
            Colors.black.withOpacity(0.75),
          ],
          stops: const [0.0, 0.25, 0.55, 1.0],
        ),
      ),
    );
  }
}

// ── Side Actions ──────────────────────────────────────────────────────────────
class _SideActions extends StatelessWidget {
  final ReelModel reel;
  final ReelsController controller;

  const _SideActions({required this.reel, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Like
        ReelActionButton(
          icon: Icons.favorite_border_rounded,
          activeIcon: Icons.favorite_rounded,
          label: controller.formatCount(reel.likesCount),
          isActive: reel.isLiked,
          activeColor: Colors.redAccent,
          onTap: () => controller.toggleLike(reel.id),
        ),
        const SizedBox(height: 20),
        // Comment
        ReelActionButton(
          icon: Icons.chat_bubble_outline_rounded,
          label: controller.formatCount(reel.commentsCount),
          isActive: false,
          activeColor: AppColors.primaryColor,
          onTap: () {},
        ),
        const SizedBox(height: 20),
        // Share
        ReelActionButton(
          icon: Icons.send_rounded,
          label: controller.formatCount(reel.sharesCount),
          isActive: false,
          activeColor: AppColors.primaryColor,
          onTap: () {},
        ),
        const SizedBox(height: 20),
        // Bookmark
        ReelActionButton(
          icon: Icons.bookmark_border_rounded,
          activeIcon: Icons.bookmark_rounded,
          label: controller.formatCount(reel.bookmarksCount),
          isActive: reel.isBookmarked,
          activeColor: AppColors.primaryColor,
          onTap: () => controller.toggleBookmark(reel.id),
        ),
        const SizedBox(height: 20),
        // More options
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.12),
            ),
            child: const Icon(
              Icons.more_horiz_rounded,
              color: AppColors.textColor,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }
}
