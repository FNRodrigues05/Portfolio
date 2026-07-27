import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/di/data_di.dart';
import '../../domain/di/domain_di.dart';
import '../../presentation/di/presentation_di.dart';

final injector = GetIt.instance;

Future<void> initInjector() async {
  injector.registerLazySingleton(() => http.Client());

  final prefs = await SharedPreferences.getInstance();
  injector.registerLazySingleton<SharedPreferences>(() => prefs);

  setUpDataDi();
  setUpDomainDi();
  setUpPresentationDi();
}
