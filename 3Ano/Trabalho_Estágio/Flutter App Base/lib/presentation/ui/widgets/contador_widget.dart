import 'package:flutter/material.dart';

class ContadorWidget extends StatelessWidget {
  const ContadorWidget({super.key, required this.counter});

  final int counter;

  @override
  Widget build(BuildContext context) {
    Color cores() {
      if (counter == 0) {
        return Colors.red;
      } else if (counter >= 10) {
        return Colors.green;
      }
      return Colors.blueGrey;
    }

    return Text(
      '$counter',
      style: Theme.of(
        context,
      ).textTheme.headlineMedium?.copyWith(color: cores()),
    );
  }
}
