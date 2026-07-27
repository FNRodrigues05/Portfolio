import 'package:fpdart/fpdart.dart';
import 'package:poke_api/domain/errors/app_error.dart';

extension EitherExtensions<T> on T {
  Right<AppError, T> toRight() {
    return Right(this);
  }

  Either<T, R> toLeft<R>() {
    return Left(this);
  }
}
