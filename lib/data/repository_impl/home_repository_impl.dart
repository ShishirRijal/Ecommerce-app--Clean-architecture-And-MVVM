import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/data/mapper/home_response_mapper.dart';
import 'package:ecommerce_app/domain/repositories/home_repository.dart';

import '../../domain/model/home_object.dart';
import '../data.dart';

class HomeRepositoryImpl extends HomeRepository {
  final NetworkInfo networkInfo;
  final RemoteDataSource remoteDataSource;
  HomeRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, HomeObject>> getHome() async {
    if (await networkInfo.isConnected) {
      //* It's safe to call api
      try {
        final response = await remoteDataSource.getHome();
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
