import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/domain/repositories/home_repository.dart';

import '../../data/failure/failure.dart';
import '../model/home_object.dart';

class HomeUseCase {
  final HomeRepository _repository;
  HomeUseCase(this._repository);

  Future<Either<Failure, HomeObject>> call() async {
    return await _repository.getHome();
  }
}
