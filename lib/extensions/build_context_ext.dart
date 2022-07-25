import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension BuildContextExtension on BuildContext {
  AppLocalizations get localization => AppLocalizations.of(this)!;

  navigateBack() => Navigator.of(this).pop();

  Object? get arguments => ModalRoute.of(this)!.settings.arguments;
}
