import 'package:get_it/get_it.dart';

import '../../domain/repositories/app_repository.dart';
import '../datasources/local_app_datasource.dart';
import '../repositories/app_repository_impl.dart';

final injector = GetIt.instance;

void setUpDataDi() {
  injector.registerLazySingleton<LocalAppDataSource>(
    () => LocalAppDataSource(),
  );

  injector.registerLazySingleton<AppRepository>(
    () => AppRepositoryImpl(injector<LocalAppDataSource>()),
  );
}
