import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error%20handling/failures.dart';

abstract class BaseUseCase<T,Parameters>{
  Future<Either<Failures,T>>call(Parameters parameters);
}