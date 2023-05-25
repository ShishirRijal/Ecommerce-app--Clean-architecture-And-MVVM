import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_object.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject({
    required String username,
    required String password,
  }) = _LoginObject;
}
