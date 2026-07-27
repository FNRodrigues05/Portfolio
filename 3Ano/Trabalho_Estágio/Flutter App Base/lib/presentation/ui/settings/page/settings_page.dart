import 'package:exercicio_um/presentation/ui/settings/bloc/settings_bloc.dart';
import 'package:exercicio_um/presentation/ui/settings/page/settings_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetIt.instance<SettingsBloc>()..add(const LoadSettingsEvent()),
      child: const SettingsLayout(),
    );
  }
}
