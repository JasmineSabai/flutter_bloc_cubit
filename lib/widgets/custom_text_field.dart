import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../theme/app_text_theme.dart';

class CustomTextField extends StatefulWidget {
  final Function()? onPressed;
  final String label;
  final String? placeHolderText;
  final String? hintText;
  final Color? bgColor;
  final Color? strokeColor;
  final TextEditingController controller;
  final bool isPassword;

  const CustomTextField({
    super.key,
    this.onPressed,
    required this.label,
    this.placeHolderText,
    this.hintText,
    this.bgColor,
    this.strokeColor,
    required this.controller,
    this.isPassword = false,
  });

  @override
  State<StatefulWidget> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  @override
  void dispose() {
    widget.controller.dispose(); // Clean up
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppTextTheme.body.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        TextField(
          obscureText: widget.isPassword,
          controller: widget.controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            hintText: widget.hintText,
            hintStyle: AppTextTheme.body.copyWith(color: Colors.grey),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Colors.grey.withValues(alpha: 0.8),
                // Color when not focused
                width: 0.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: AppColors.primary.withValues(alpha: 0.8),
                // Color when focused
                width: 0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
