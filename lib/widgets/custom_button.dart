import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../theme/app_text_theme.dart';

class CustomButton extends StatefulWidget {
  final Function()? onPressed;
  final String label;
  final Color buttonColor;
  final Color textColor;
  final bool isDisabled;
  final bool isLightColor;

  const CustomButton({
    super.key,
    this.onPressed,
    required this.label,
    this.buttonColor = AppColors.primary,
    this.textColor = Colors.white,
    this.isDisabled = false,
    this.isLightColor = false,
  });

  @override
  State<StatefulWidget> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: widget.isDisabled
              ? AppColors.disable
              : (widget.isLightColor
                    ? AppColors.secondary
                    : widget.buttonColor),
        ),
        child: Text(
          widget.label,
          style: AppTextTheme.body(context).copyWith(
            color: widget.isDisabled
                ? AppColors.disable
                : (widget.isLightColor ? AppColors.primary : widget.textColor),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
