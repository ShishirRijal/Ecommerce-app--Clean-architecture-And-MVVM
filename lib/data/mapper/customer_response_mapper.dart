import 'package:ecommerce_app/app/extensions.dart';
import 'package:ecommerce_app/data/data.dart';

import '../../domain/model/model.dart';

/// Convert the nullable [CustomerResponse] to a non-nullable [Customer] object.
extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
      id: this?.id?.orEmpty() ?? '',
      name: this?.name?.orEmpty() ?? '',
      notifications: this?.notifications?.orEmpty() ?? '',
    );
  }
}
