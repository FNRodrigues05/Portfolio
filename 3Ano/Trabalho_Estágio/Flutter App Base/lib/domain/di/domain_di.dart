import 'package:get_it/get_it.dart';

import '../repositories/app_repository.dart';
import '../use_cases/clear_all_use_case.dart';
import '../use_cases/get_counter_use_case.dart';
import '../use_cases/get_name_use_case.dart';
import '../use_cases/save_counter_use_case.dart';
import '../use_cases/save_name_use_case.dart';

final injector = GetIt.instance;

void setUpDomainDi() {
  injector.registerFactory<SaveCounterUseCase>(
    () => SaveCounterUseCase(injector<AppRepository>()),
  );
  injector.registerFactory<GetCounterUseCase>(
    () => GetCounterUseCase(injector<AppRepository>()),
  );
  injector.registerFactory<SaveNameUseCase>(
    () => SaveNameUseCase(injector<AppRepository>()),
  );
  injector.registerFactory<GetNameUseCase>(
    () => GetNameUseCase(injector<AppRepository>()),
  );
  injector.registerFactory<ClearAllUseCase>(
    () => ClearAllUseCase(injector<AppRepository>()),
  );
}
