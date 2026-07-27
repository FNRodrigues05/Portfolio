import 'package:dart_either/dart_either.dart';

import '../errors/app_error.dart';

abstract class AppRepository {
  Future<Either<AppError, int>> saveCounter(int value);

  Future<Either<AppError, int?>> getCounter();

  Future<Either<AppError, String>> saveName(String name);

  Future<Either<AppError, String?>> getName();

  Future<Either<AppError, void>> clearAll();
}
