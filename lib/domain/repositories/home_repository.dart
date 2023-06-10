import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/domain/model/home_object.dart';

import '../../data/failure/failure.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeObject>> getHome();
}
