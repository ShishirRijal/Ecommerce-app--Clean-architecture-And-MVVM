import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/domain/repositories/home_repository.dart';

import '../../data/failure/failure.dart';
import '../model/home_object.dart';
import 'base_usecase.dart';

class HomeUseCase extends BaseUseCase<void, HomeObject> {
  final HomeRepository _repository;
  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, HomeObject>> call(void params) async {
    return await _repository.getHome();
  }
}
