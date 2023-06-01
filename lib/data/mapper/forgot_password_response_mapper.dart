import 'package:ecommerce_app/app/extensions.dart';
import 'package:ecommerce_app/data/data.dart';

extension ForgotPasswordResponseMapper on ForgotPasswordResponse? {
  String toDomain() {
    return this?.support.orEmpty() ?? '';
  }
}
