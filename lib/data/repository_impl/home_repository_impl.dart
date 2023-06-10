import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/data/mapper/home_response_mapper.dart';
import 'package:ecommerce_app/domain/repositories/home_repository.dart';

import '../../domain/model/home_object.dart';
import '../data.dart';
import '../data_source/local_data_source.dart';

class HomeRepositoryImpl extends HomeRepository {
  final NetworkInfo networkInfo;
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  HomeRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });
  @override
  Future<Either<Failure, HomeObject>> getHome() async {
    try {
      // if we get data from cache, return it
      final response = await localDataSource.getHome();
      return Right(response.toDomain());
    } catch (cacheError) {
      // if we don't get data from cache, call api
      if (await networkInfo.isConnected) {
        //* It's safe to call api
        try {
          final response = await remoteDataSource.getHome();
          if (response.status == ApiInternalStatus.SUCCESS) // success
          {
            // when we get data from server, save it to cache
            localDataSource.saveHomeToCache(response);
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
}
