import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/l10n/generated/app_localizations.dart';

enum PokemonTypes {
  normal(Color(0xFFA8A77A), FontAwesomeIcons.circleDot, Colors.grey),
  fire(Color(0xFFEE8130), FontAwesomeIcons.fireFlameSimple, Colors.red),
  water(Color(0xFF5283C5), FontAwesomeIcons.droplet, Colors.blue),
  electric(
    Color(0xFFF7D02C),
    FontAwesomeIcons.boltLightning,
    Color(0xFFFFFF00),
  ),
  grass(Color(0xFF7AC74C), FontAwesomeIcons.envira, Colors.green),
  ice(Color(0xFF96D9D6), FontAwesomeIcons.snowflake, Color(0xFF81D4F4)),
  fighting(Color(0xFFC22E28), FontAwesomeIcons.handFist, Colors.red),
  poison(Color(0xFFA33EA1), FontAwesomeIcons.skull, Colors.purple),
  ground(Color(0xFFE2BF65), FontAwesomeIcons.mountain, Color(0xFFEF6C00)),
  flying(Color(0xFFA98FF3), FontAwesomeIcons.dove, Colors.lightBlueAccent),
  psychic(Color(0xFFF95587), FontAwesomeIcons.spiral, Color(0xFFE57373)),
  bug(Color(0xFFA6B91A), FontAwesomeIcons.bug, Colors.lightGreen),
  rock(Color(0xFFB6A136), FontAwesomeIcons.solidGem, Color(0xFFA1887F)),
  ghost(Color(0xFF735797), FontAwesomeIcons.ghost, Color(0xFFB388FF)),
  dragon(Color(0xFF6F35FC), FontAwesomeIcons.dragon, Color(0xFF1565C0)),
  dark(Color(0xFF705746), FontAwesomeIcons.moon, Colors.black87),
  steel(Color(0xFFB7B7CE), FontAwesomeIcons.hexagon, Colors.white54),
  fairy(Color(0xFFD685AD), FontAwesomeIcons.wandSparkles, Colors.pinkAccent);

  final Color baseColor;
  final FaIconData icon;
  final Color iconColor;

  const PokemonTypes(this.baseColor, this.icon, this.iconColor);

  String getLocalizedName(BuildContext context) {
    switch (this) {
      case PokemonTypes.normal:
        return AppLocalizations.of(context)!.normal;
      case PokemonTypes.fire:
        return AppLocalizations.of(context)!.fire;
      case PokemonTypes.water:
        return AppLocalizations.of(context)!.water;
      case PokemonTypes.electric:
        return AppLocalizations.of(context)!.electric;
      case PokemonTypes.grass:
        return AppLocalizations.of(context)!.grass;
      case PokemonTypes.ice:
        return AppLocalizations.of(context)!.ice;
      case PokemonTypes.fighting:
        return AppLocalizations.of(context)!.fighting;
      case PokemonTypes.poison:
        return AppLocalizations.of(context)!.poison;
      case PokemonTypes.ground:
        return AppLocalizations.of(context)!.ground;
      case PokemonTypes.flying:
        return AppLocalizations.of(context)!.flying;
      case PokemonTypes.psychic:
        return AppLocalizations.of(context)!.psychic;
      case PokemonTypes.bug:
        return AppLocalizations.of(context)!.bug;
      case PokemonTypes.rock:
        return AppLocalizations.of(context)!.rock;
      case PokemonTypes.ghost:
        return AppLocalizations.of(context)!.ghost;
      case PokemonTypes.dragon:
        return AppLocalizations.of(context)!.dragon;
      case PokemonTypes.dark:
        return AppLocalizations.of(context)!.dark;
      case PokemonTypes.steel:
        return AppLocalizations.of(context)!.steel;
      case PokemonTypes.fairy:
        return AppLocalizations.of(context)!.fairy;
    }
  }
}
