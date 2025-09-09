import 'package:flutter/material.dart';

import '../l10n/l10n_extension.dart';
import '../widgets/general_alert_dialog.dart';

class DisplayAlert {
  static showGeneralDialog({
    required BuildContext context,
    required String title,
    required String content,
    VoidCallback? onConfirm,
    bool isHideCancelBtn = false,
    bool isCancelable = true
  }) {
    showDialog(
      barrierDismissible: isCancelable,
      context: context,
      builder: (context) => GeneralAlertDialog(
        title: title,
        content: content,
        onConfirm: onConfirm,
        isHideCancelBtn: isHideCancelBtn,
        isCancelable: isCancelable,
      ),
    );
  }

  static showGeneralSnackBar({
    required BuildContext context,
    String? content
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(content ?? S.of(context)!.error)),
    );
  }
}
