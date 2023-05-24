import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/data/data.dart';
import 'package:ecommerce_app/data/data_source/remote_data_source.dart';
import 'package:ecommerce_app/data/mapper/mapper.dart';
import 'package:ecommerce_app/data/network/network_info.dart';
import 'package:ecommerce_app/data/request/login_request.dart';
import 'package:ecommerce_app/domain/model/model.dart';
import 'package:ecommerce_app/domain/repositories/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

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
      final response = await remoteDataSource.login(loginRequest);
      if (response.status == 0) // success
      {
        return Right(response.toDomain());
      } else // failure
      {
        return Left(Failure(
            code: 409,
            message: response.message ?? 'An unknown error occurred!'));
      }
    } else {
      //! Oops.. There's no internet, so no point of calling api..
      //! Let's return Failure instead
      return Left(Failure(
          code: 200,
          message: 'No internet connection! Please check your connection.'));
    }
  }
}
