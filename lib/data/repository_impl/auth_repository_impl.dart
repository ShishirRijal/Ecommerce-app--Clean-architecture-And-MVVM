import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/data/data.dart';
import 'package:ecommerce_app/domain/model/model.dart';
import 'package:ecommerce_app/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final NetworkInfo networkInfo;
  final RemoteDataSource remoteDataSource;

  AuthRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await networkInfo.isConnected) {
      //* It's safe to call api
      try {
        final response = await remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.SUCCESS) // success
        {
          return Right(response.toDomain());
        } else // failure
        {
          return Left(Failure(
            response.status ?? ApiInternalStatus.FAILURE,
            response.message ?? 'An unknown error occurred!',
          ));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //! Oops.. There's no internet, so no point of calling api..
      //! Let's return Failure instead
      return Left(StatusCode.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    if (await networkInfo.isConnected) {
      //* It's safe to call api
      try {
        final response = await remoteDataSource.register(registerRequest);
        if (response.status == ApiInternalStatus.SUCCESS) // success
        {
          return Right(response.toDomain());
        } else // failure
        {
          return Left(Failure(
            response.status ?? ApiInternalStatus.FAILURE,
            response.message ?? 'An unknown error occurred!',
          ));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //! Oops.. There's no internet, so no point of calling api..
      //! Let's return Failure instead
      return Left(StatusCode.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
