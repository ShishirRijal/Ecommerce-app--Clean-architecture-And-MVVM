import 'package:dartz/dartz.dart';

import '../../data/failure/failure.dart';

/// The [Base_UseCase] class...
abstract class BaseUseCase<Params, T> {
  Future<Either<Failure, T>> call(Params params);
}
