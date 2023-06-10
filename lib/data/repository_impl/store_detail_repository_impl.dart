import 'package:ecommerce_app/data/mapper/store_detail_mapper.dart';
import 'package:ecommerce_app/domain/model/store_detail.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/domain/repositories/store_detail_repository.dart';

import '../data.dart';
import '../data_source/local_data_source.dart';

class StoreDetailRepositoryImpl extends StoreDetailRepository {
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  StoreDetailRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, StoreDetail>> getStoreDetail() async {
    try {
      // get data from cache
      final response = await localDataSource.getStoreDetails();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await networkInfo.isConnected) {
        try {
          final response = await remoteDataSource.getStoreDetails();
          if (response.status == ApiInternalStatus.SUCCESS) {
            localDataSource.saveStoreDetailsToCache(response);
            return Right(response.toDomain());
          } else {
            return Left(Failure(response.status ?? ResponseCode.UNKNOWN,
                response.message ?? ResponseMessage.UNKNOWN));
          }
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        return Left(StatusCode.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }
}
