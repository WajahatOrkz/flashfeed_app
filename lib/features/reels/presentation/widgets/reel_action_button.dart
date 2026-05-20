import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ReelActionButton extends StatefulWidget {
  final IconData icon;
  final IconData? activeIcon;
  final String label;
  final bool isActive;
  final Color activeColor;
  final VoidCallback onTap;
  final double iconSize;

  const ReelActionButton({
    super.key,
    required this.icon,
    this.activeIcon,
    required this.label,
    required this.isActive,
    required this.activeColor,
    required this.onTap,
    this.iconSize = 28,
  });

  @override
  State<ReelActionButton> createState() => _ReelActionButtonState();
}

class _ReelActionButtonState extends State<ReelActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
    _scaleAnim = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.35), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.35, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _handleTap() {
    _animController.forward(from: 0);
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ScaleTransition(
            scale: _scaleAnim,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.12),
              ),
              child: Icon(
                widget.isActive && widget.activeIcon != null
                    ? widget.activeIcon
                    : widget.icon,
                color: widget.isActive ? widget.activeColor : AppColors.textColor,
                size: widget.iconSize,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.label,
            style: const TextStyle(
              color: AppColors.textColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              shadows: [
                Shadow(color: Colors.black54, blurRadius: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
