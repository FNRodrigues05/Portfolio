import 'package:exercicio_um/presentation/routes/routes.dart';
import 'package:exercicio_um/presentation/ui/my_home/bloc/my_home_bloc.dart';
import 'package:exercicio_um/presentation/ui/widgets/contador_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extension.dart';

class MyHomeLayout extends StatefulWidget {
  const MyHomeLayout({super.key});

  @override
  State<MyHomeLayout> createState() => _MyHomeLayoutState();
}

class _MyHomeLayoutState extends State<MyHomeLayout> {
  @override
  void initState() {
    super.initState();
    context.read<MyHomeBloc>().add(const LoadMyHomeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyHomeBloc, MyHomeState>(
      listenWhen: (previous, current) => previous.counter != current.counter,
      listener: (context, state) {
        if (state.counter % 10 == 0) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(SnackBar(content: Text('Alvo atingido!')));
        }
      },

      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.settings, size: 50, color: Colors.green),
            onPressed: () async {
              await context.pushNamed(Routes.settingsPage);
              if (context.mounted) {
                context.read<MyHomeBloc>().add(const LoadMyHomeEvent());
              }
            },
          ),

          backgroundColor: Theme.of(context).colorScheme.inversePrimary,

          title: BlocBuilder<MyHomeBloc, MyHomeState>(
            builder: (context, state) {
              return Text(
                state.name.isEmpty
                    ? context.localizations.appTitle
                    : context.localizations.greeting(state.name),
              );
            },
          ),
          actions: [
            FloatingActionButton(
              heroTag: 'btnReset',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AlertDialog(
                      title: Text(context.localizations.resetAttention),
                      content: Text(context.localizations.resetConfirm),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            context.pop(dialogContext);
                          },
                          child: Text(context.localizations.no),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.read<MyHomeBloc>().add(
                              const ResetHomeEvent(),
                            );
                            context.pop(dialogContext);
                          },
                          child: Text(context.localizations.yes),
                        ),
                      ],
                      backgroundColor: Colors.lightGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    );
                  },
                );
              },
              tooltip: 'Reset',
              child: const Icon(Icons.redo),
            ),
          ],
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onDoubleTap: () {
            context.read<MyHomeBloc>().add(const IncrementHomeEvent());
          },
          child: Center(
            child: Column(
              mainAxisAlignment: .center,
              children: [
                Text(context.localizations.pushMessage),
                BlocBuilder<MyHomeBloc, MyHomeState>(
                  builder: (context, state) {
                    return ContadorWidget(counter: state.counter);
                  },
                ),

                BlocBuilder<MyHomeBloc, MyHomeState>(
                  builder: (context, state) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.lista.length,
                      itemBuilder: (context, index) {
                        return Text(
                          state.lista[index],
                          textAlign: TextAlign.center,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          spacing: 10,
          children: [
            FloatingActionButton(
              heroTag: 'btnMenos',
              onPressed: () {
                context.read<MyHomeBloc>().add(const SubtractHomeEvent());
              },
              tooltip: 'Subtract',
              child: const Icon(Icons.remove),
            ),
            FloatingActionButton(
              heroTag: 'btnMais',
              onPressed: () {
                context.read<MyHomeBloc>().add(const IncrementHomeEvent());
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
