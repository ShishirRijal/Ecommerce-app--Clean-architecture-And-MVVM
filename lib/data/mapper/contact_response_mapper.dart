import 'package:ecommerce_app/app/extensions.dart';
import 'package:ecommerce_app/data/data.dart';

import '../../domain/model/model.dart';

/// Convert the nullable [ContactResponse] to a non-nullable [Contact] object.
extension ContactResponseMapper on ContactResponse? {
  Contact toDomain() {
    return Contact(
      // add phone while checking null safety
      phone: this?.phone?.orEmpty() ?? '',
      email: this?.email?.orEmpty() ?? '',
      website: this?.website?.orEmpty() ?? '',
    );
  }
}
