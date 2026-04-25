import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';

class EditProfileAvatar extends StatelessWidget {
  final VoidCallback? onChange;

  const EditProfileAvatar({super.key, this.onChange});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onChange,
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              // Avatar placeholder
              Center(
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.grey.shade600,
                ),
              ),
              // "CHANGE" overlay
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 30,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'CHANGE',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
