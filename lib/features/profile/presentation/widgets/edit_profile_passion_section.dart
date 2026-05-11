import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/theme/app_colors.dart';
import '../controllers/edit_profile_controller.dart';
import 'passion_bottom_sheet.dart';

class EditProfilePassionSection extends StatelessWidget {
  final EditProfileController controller;

  const EditProfilePassionSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'YOUR PASSION',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            ElevatedButton(
              onPressed: () => PassionBottomSheet.show(context, controller),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 0,
                ),
                minimumSize: const Size(60, 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Add',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.only(bottom: 8),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.primaryColor, width: 1.5),
            ),
          ),
          child: Obx(
            () => controller.passions.isEmpty
                ? const Center(
                    child: Text(
                      'No passions selected',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  )
                : Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: controller.passions.map((passion) {
                      return Chip(
                        backgroundColor: AppColors.fieldBgColor,
                        labelStyle: const TextStyle(color: Colors.white),
                        label: Text(passion),
                        deleteIcon: const Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.white,
                        ),
                        onDeleted: () => controller.togglePassion(passion),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(color: AppColors.primaryColor),
                        ),
                      );
                    }).toList(),
                  ),
          ),
        ),
      ],
    );
  }
}
