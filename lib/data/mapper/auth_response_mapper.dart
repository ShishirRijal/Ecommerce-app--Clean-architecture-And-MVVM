import 'package:ecommerce_app/data/data.dart';

import '../../domain/model/model.dart';

extension AuthResponseMapper on AuthResponse? {
  Authentication toDomain() {
    return Authentication(
      contact: this?.contactResponse?.toDomain(),
      customer: this?.customerResponse?.toDomain(),
    );
  }
}
