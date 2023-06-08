import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_object.freezed.dart';

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject({
    required String countryMobileCode,
    required String username,
    required String email,
    required String password,
    required String mobileNumber,
    required String profilePicture,
  }) = _RegisterObject;
}
