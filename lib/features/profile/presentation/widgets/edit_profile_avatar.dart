import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/theme/app_colors.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileAvatar extends StatelessWidget {
  final VoidCallback? onChange;

  const EditProfileAvatar({super.key, this.onChange});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EditProfileController>();
    return Center(
      child: GestureDetector(
        onTap: onChange,
        child: Obx(() {
          final pickedFile = controller.pickedImage.value;
          final networkUrl = controller.currentImageUrl.value;

          ImageProvider? imageProvider;
          if (pickedFile != null) {
            imageProvider = FileImage(pickedFile);
          } else if (networkUrl.isNotEmpty) {
            imageProvider = NetworkImage(networkUrl);
          }

          return Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(16),
              image: imageProvider != null
                  ? DecorationImage(image: imageProvider, fit: BoxFit.cover)
                  : null,
            ),
            child: Stack(
              children: [
                if (imageProvider == null)
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
          );
        }),
      ),
    );
  }
}
