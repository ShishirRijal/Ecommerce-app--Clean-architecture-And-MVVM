import 'package:dartz/dartz.dart';

import '../../data/failure/failure.dart';
import '../model/store_detail.dart';

abstract class StoreDetailRepository {
  Future<Either<Failure, StoreDetail>> getStoreDetail();
}
