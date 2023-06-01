import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/data/data.dart';

import '../repositories/respositories.dart';

class ForgotPasswordUseCase {
  final ForgotPasswordRepository _repository;
  ForgotPasswordUseCase(this._repository);

  Future<Either<Failure, String>> call(String email) async {
    return await _repository.forgotPassword(email: email);
  }
}
