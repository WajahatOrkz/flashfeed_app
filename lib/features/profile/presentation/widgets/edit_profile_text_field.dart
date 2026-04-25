import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';

class EditProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final Color textColor;

  const EditProfileTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black26, // Slightly dark background like the design
        border: Border(
          bottom: BorderSide(color: AppColors.primaryColor, width: 1.5),
        ),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 13,
            fontWeight: FontWeight.normal,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(12),
        ),
      ),
    );
  }
}
