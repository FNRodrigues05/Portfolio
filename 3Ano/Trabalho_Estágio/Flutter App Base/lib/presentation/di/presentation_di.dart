import 'package:exercicio_um/presentation/ui/my_home/bloc/my_home_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../domain/use_cases/get_counter_use_case.dart';
import '../../domain/use_cases/get_name_use_case.dart';
import '../../domain/use_cases/save_counter_use_case.dart';
import '../../domain/use_cases/save_name_use_case.dart';
import '../ui/settings/bloc/settings_bloc.dart';

final _injector = GetIt.instance;

void setUpPresentationDi() {
  _injector.registerFactory<MyHomeBloc>(
    () => MyHomeBloc(
      _injector<GetCounterUseCase>(),
      _injector<SaveCounterUseCase>(),
      _injector<GetNameUseCase>(),
    ),
  );
  _injector.registerFactory<SettingsBloc>(
    () =>
        SettingsBloc(_injector<GetNameUseCase>(), _injector<SaveNameUseCase>()),
  );
}
