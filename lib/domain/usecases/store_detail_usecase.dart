import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/data/failure/failure.dart';
import 'package:ecommerce_app/domain/repositories/store_detail_repository.dart';

import '../model/store_detail.dart';
import 'base_usecase.dart';

class StoreDetailUseCase extends BaseUseCase<void, StoreDetail> {
  StoreDetailRepository repository;

  StoreDetailUseCase(this.repository);

  @override
  Future<Either<Failure, StoreDetail>> call(void params) {
    return repository.getStoreDetail();
  }
}
