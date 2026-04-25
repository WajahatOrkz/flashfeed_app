import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/theme/app_colors.dart';
import '../controllers/edit_profile_controller.dart';
import '../widgets/edit_profile_avatar.dart';
import '../widgets/edit_profile_text_field.dart';
import '../widgets/passion_bottom_sheet.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final controller = Get.put(EditProfileController());

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'EDIT PROFILE',
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile Picture Section
            EditProfileAvatar(
              onChange: () {
                // Handle changing picture
              },
            ),
            const SizedBox(height: 32),

            // NAME Section
            const Text(
              'NAME',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            EditProfileTextField(
              controller: controller.nameController,
              hintText: 'Enter your name',
              textColor: AppColors.primaryColor,
            ),
            const SizedBox(height: 24),

            // EMAIL Section
            const Text(
              'EMAIL',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            EditProfileTextField(
              controller: controller.emailController,
              hintText: 'Enter your email',
              textColor: AppColors.primaryColor,
            ),
            const SizedBox(height: 24),

            // ABOUT YOU Section
            const Text(
              'ABOUT YOU',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            EditProfileTextField(
              controller: controller.aboutController,
              hintText:
                  'Tell people about you, what you like what are your passions...',
              maxLines: 3,
            ),
            const SizedBox(height: 24),

            // YOUR PASSION Section
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
                              side: const BorderSide(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
              ),
            ),
            const SizedBox(height: 48),

            // UPDATE PROFILE Button
            ElevatedButton(
              onPressed: controller.updateProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'UPDATE PROFILE',
                style: TextStyle(
                  color: Colors
                      .black, // Dark text on primary button, matching the design
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
