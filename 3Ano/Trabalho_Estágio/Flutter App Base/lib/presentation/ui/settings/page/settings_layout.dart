import 'package:exercicio_um/presentation/ui/settings/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../routes/routes.dart';

class SettingsLayout extends StatefulWidget {
  const SettingsLayout({super.key});

  @override
  State<SettingsLayout> createState() => _SettingsLayoutState();
}

class _SettingsLayoutState extends State<SettingsLayout> {
  final TextEditingController _nomeController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home, size: 50, color: Colors.green),
          onPressed: () {
            context.pop(Routes.homePage);
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(context.localizations.settingsTitle),
      ),

      body: BlocListener<SettingsBloc, SettingsState>(
        listener: (context, state) {},
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nomeController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: context.localizations.inputNameLabel,
                ),
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: .center,
                spacing: 50,
                children: [
                  FloatingActionButton.extended(
                    heroTag: 'saveName',
                    onPressed: () {
                      context.read<SettingsBloc>().add(
                        SaveDataSettingsEvent(_nomeController.text),
                      );
                    },
                    tooltip: 'SaveName',
                    label: Text(context.localizations.btnSave),
                  ),
                  FloatingActionButton.extended(
                    heroTag: 'clearData',
                    onPressed: () {
                      context.read<SettingsBloc>().add(
                        const ClearDataSettingsEvent(),
                      );
                    },
                    tooltip: 'ClearAll',
                    label: Text(context.localizations.btnClearData),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
