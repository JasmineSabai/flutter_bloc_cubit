import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget child;
  final bool isBordered;
  final Color? bgColor;

  const CustomTextButton({
    super.key,
    this.onPressed,
    required this.child,
    this.isBordered = false,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: bgColor ?? Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        side: isBordered
            ? const BorderSide(
                color: Colors.grey, // Color of the border
                width: 0.5, // Width of the border
              )
            : BorderSide.none,
        // Padding around the text
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5), // Rounded corners
        ),
        overlayColor: Colors.grey,
      ),
      child: child,
    );
  }
}
