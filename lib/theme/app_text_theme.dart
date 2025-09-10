import 'package:flutter/material.dart';

class AppTextTheme {
  static TextStyle title1(BuildContext context) {
    return TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).textTheme.titleLarge?.color ?? Colors.black,
    );
  }

  static TextStyle title2(BuildContext context) {
    return TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).textTheme.titleMedium?.color ?? Colors.black,
    );
  }

  static TextStyle title3(BuildContext context) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).textTheme.titleSmall?.color ?? Colors.black,
    );
  }

  static TextStyle body(BuildContext context) {
    return TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.normal,
      color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black,
    );
  }

  static TextStyle caption(BuildContext context) {
    return TextStyle(
      fontSize: 8,
      fontWeight: FontWeight.w300,
      color: Theme.of(context).textTheme.labelSmall?.color ?? Colors.black,
    );
  }

}
