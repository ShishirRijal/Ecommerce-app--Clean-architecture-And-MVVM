import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/data/data.dart';
import 'package:ecommerce_app/domain/model/auth.dart';

/// This class is used as [AuthRepository] interface to
/// implement the methods in [AuthRepositoryImpl] class.
abstract class AuthRepository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
}
