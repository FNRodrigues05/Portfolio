import 'package:flutter/cupertino.dart';

import '../../../core/l10n/generated/app_localizations.dart';

String getLocalizationStats(BuildContext context, String stat) {
  switch (stat) {
    case 'hp':
      return AppLocalizations.of(context)!.pokeHP;
    case 'attack':
      return AppLocalizations.of(context)!.pokeAttack;
    case 'defense':
      return AppLocalizations.of(context)!.pokeDefense;
    case 'special-attack':
      return AppLocalizations.of(context)!.pokeSpecialAttack;
    case 'special-defense':
      return AppLocalizations.of(context)!.pokeSpecialDefense;
    case 'speed':
      return AppLocalizations.of(context)!.pokeSpeed;
    default:
      return stat;
  }
}
