import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_response.dart';
part 'store_detail_response.g.dart';

@JsonSerializable()
class StoreDetailResponse extends BaseResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'details')
  String? details;
  @JsonKey(name: 'services')
  String? services;
  @JsonKey(name: 'about')
  String? about;

  StoreDetailResponse(
      this.id, this.title, this.image, this.details, this.services, this.about);

  factory StoreDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreDetailResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StoreDetailResponseToJson(this);
}
