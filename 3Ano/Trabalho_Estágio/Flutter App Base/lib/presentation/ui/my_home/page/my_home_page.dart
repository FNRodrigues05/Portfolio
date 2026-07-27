import 'package:exercicio_um/presentation/ui/my_home/bloc/my_home_bloc.dart';
import 'package:exercicio_um/presentation/ui/my_home/page/my_home_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetIt.instance<MyHomeBloc>()..add(const LoadMyHomeEvent()),
      child: const MyHomeLayout(),
    );
  }
}
