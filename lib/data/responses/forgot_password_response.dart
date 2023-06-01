import 'package:ecommerce_app/data/data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'forgot_password_response.g.dart';

@JsonSerializable()
class ForgotPasswordResponse extends BaseResponse {
  @JsonKey(name: 'support')
  String support;

  ForgotPasswordResponse({required this.support});

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);
}
