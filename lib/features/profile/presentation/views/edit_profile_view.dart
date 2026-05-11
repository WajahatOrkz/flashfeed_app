import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/theme/app_colors.dart';
import '../controllers/edit_profile_controller.dart';
import '../widgets/edit_profile_avatar.dart';
import '../widgets/edit_profile_passion_section.dart';
import '../widgets/edit_profile_text_field.dart';
import '../widgets/edit_profile_update_button.dart';
import '../widgets/image_picker_sheet.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProfileController());

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
        body: Obx(
          () => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      EditProfileAvatar(
                        onChange: () =>
                            ImagePickerSheet.show(context, controller),
                      ),
                      const SizedBox(height: 32),

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

                      EditProfilePassionSection(controller: controller),
                      const SizedBox(height: 48),

                      EditProfileUpdateButton(controller: controller),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
