import 'package:json_annotation/json_annotation.dart';

import 'base_response.dart';
part 'home_data_response.g.dart';

@JsonSerializable()
class ServiceResponse extends BaseResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;

  ServiceResponse({
    required this.id,
    required this.title,
    required this.image,
  });
  // to json

  factory ServiceResponse.fromJson(Map<String, dynamic> json) =>
      _$ServiceResponseFromJson(json);

  // from json
  Map<String, dynamic> toJson() => _$ServiceResponseToJson(this);
}

@JsonSerializable()
class StoreResponse extends BaseResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;

  StoreResponse({
    required this.id,
    required this.title,
    required this.image,
  });
  // to json

  factory StoreResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreResponseFromJson(json);

  // from json
  Map<String, dynamic> toJson() => _$StoreResponseToJson(this);
}

@JsonSerializable()
class BannerResponse extends BaseResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'link')
  String? link;
  @JsonKey(name: 'image')
  String? image;

  BannerResponse({
    required this.id,
    required this.title,
    required this.image,
  });
  // to json

  factory BannerResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerResponseFromJson(json);

  // from json
  Map<String, dynamic> toJson() => _$BannerResponseToJson(this);
}

@JsonSerializable()
class HomeDataResponse extends BaseResponse {
  @JsonKey(name: 'services')
  List<ServiceResponse>? services;
  @JsonKey(name: 'stores')
  List<StoreResponse>? stores;
  @JsonKey(name: 'banners')
  List<BannerResponse>? banners;

  HomeDataResponse({
    required this.services,
    required this.stores,
    required this.banners,
  });

  // to json
  factory HomeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDataResponseFromJson(json);

  // from json
  Map<String, dynamic> toJson() => _$HomeDataResponseToJson(this);
}

@JsonSerializable()
class HomeResponse extends BaseResponse {
  @JsonKey(name: 'data')
  HomeDataResponse? data;

  HomeResponse({
    required this.data,
  });

  // to json
  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);

  // from json
  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);
}
