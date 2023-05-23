import 'package:ecommerce_app/data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

// We define this response class to model the response from the API.
@JsonSerializable()
class AuthResponse extends BaseResponse {
  @JsonKey(name: 'customer')
  CustomerResponse? customerResponse;
  @JsonKey(name: 'contact')
  ContactResponse? contactResponse;

  // Simple constructor
  AuthResponse({
    this.contactResponse,
    this.customerResponse,
  });

  /// From Json
  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  /// Conver the [AuthResponse] object to [Json]
  @override
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}

// Sub-classes
@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'notifications')
  String? notifications;

  CustomerResponse(this.id, this.name, this.notifications);

  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactResponse {
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'website')
  String? website;

  ContactResponse(this.phone, this.email, this.website);

  factory ContactResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ContactResponseToJson(this);
}
