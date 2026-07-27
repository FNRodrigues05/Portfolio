import 'package:dart_either/dart_either.dart';
import 'package:exercicio_um/core/extensions/either_extensions.dart';
import 'package:exercicio_um/data/datasources/local_app_datasource.dart';
import 'package:exercicio_um/domain/errors/app_error.dart';
import 'package:exercicio_um/domain/repositories/app_repository.dart';

class AppRepositoryImpl implements AppRepository {
  final LocalAppDataSource _localAppDatasource;

  AppRepositoryImpl(this._localAppDatasource);

  @override
  Future<Either<AppError, void>> clearAll() async {
    try {
      final error = await _localAppDatasource.clearAll();
      if (error == null) return null.toRight();
    } on AppError {
      return AppError.unknown.toLeft();
    }
    return AppError.unknown.toLeft();
  }

  @override
  Future<Either<AppError, int?>> getCounter() async {
    try {
      final error = await _localAppDatasource.getCounter();
      return error.toRight();
    } on AppError {
      return AppError.unknown.toLeft();
    }
  }

  @override
  Future<Either<AppError, String?>> getName() async {
    try {
      final error = await _localAppDatasource.getName();
      return error.toRight();
    } on AppError {
      return AppError.unknown.toLeft();
    }
  }

  @override
  Future<Either<AppError, int>> saveCounter(int value) async {
    try {
      final error = await _localAppDatasource.saveCounter(value);
      if (error == null) return value.toRight();
    } on AppError {
      return AppError.unknown.toLeft();
    }
    return AppError.unknown.toLeft();
  }

  @override
  Future<Either<AppError, String>> saveName(String name) async {
    try {
      final error = await _localAppDatasource.saveName(name);
      if (error == null) return name.toRight();
    } on AppError {
      return AppError.unknown.toLeft();
    }
    return AppError.unknown.toLeft();
  }
}
