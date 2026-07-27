import 'package:dart_either/dart_either.dart';
import 'package:exercicio_um/domain/errors/app_error.dart';

extension EitherExtensions<T> on T {
  Right<AppError, T> toRight() {
    return Right(this);
  }

  Either<T, R> toLeft<R>() {
    return Left(this);
  }
}
