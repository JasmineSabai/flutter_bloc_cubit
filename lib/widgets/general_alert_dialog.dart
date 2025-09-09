import 'package:flutter/material.dart';

import '../l10n/l10n_extension.dart';
import '../routes/app_routes.dart';

class GeneralAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback? onConfirm;
  final bool isHideCancelBtn;
  final bool isCancelable;

  const GeneralAlertDialog({
    super.key,
    required this.title,
    required this.content,
    this.onConfirm,
    this.isHideCancelBtn = false,
    this.isCancelable = true
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: isCancelable,
      child: AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          Visibility(
            visible: !isHideCancelBtn,
            child: TextButton(
              onPressed: () => AppRoutes.pop(context),
              child: Text(S.of(context)!.cancel),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              AppRoutes.pop(context);
              if (onConfirm != null) onConfirm!();
            },
            child: Text(S.of(context)!.ok),
          ),
        ],
      ),
    );
  }
}
