import 'package:json_annotation/json_annotation.dart';
part 'forgot_password_response.g.dart';

@JsonSerializable()
class ForgotPasswordResponse {
  @JsonKey(name: 'support')
  String support;

  ForgotPasswordResponse({required this.support});

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);
}
