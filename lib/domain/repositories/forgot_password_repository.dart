import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/data/data.dart';

abstract class ForgotPasswordRepository {
  Future<Either<Failure, String>> forgotPassword({
    required String email,
  });
}
