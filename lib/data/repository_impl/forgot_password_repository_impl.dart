import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/domain/repositories/forgot_password_repository.dart';

import '../data.dart';

class ForgotPasswordRepositoryImpl extends ForgotPasswordRepository {
  final NetworkInfo networkInfo;
  final RemoteDataSource remoteDataSource;
  ForgotPasswordRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, String>> forgotPassword(
      {required String email}) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.forgotPassword(email);
        if (response.status == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(
            response.status ?? ResponseCode.UNKNOWN,
            response.message ?? ResponseMessage.UNKNOWN,
          ));
        }
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(StatusCode.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
