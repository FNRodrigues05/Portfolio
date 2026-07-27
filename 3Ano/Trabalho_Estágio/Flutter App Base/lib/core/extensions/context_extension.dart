import 'package:flutter/material.dart';
import '../l10n/generated/app_localizations.dart';

extension BuildContextExtension on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this)!;
}
