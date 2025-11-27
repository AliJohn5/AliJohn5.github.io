import 'package:flutter/material.dart';
import 'package:login_template/l10n/app_localizations.dart';

void showMessage(BuildContext context, String? message) {
  if (!context.mounted) return;
  final tr = AppLocalizations.of(context)!;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message ?? tr.somethingWrong,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: 15,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
    ),
  );
}
