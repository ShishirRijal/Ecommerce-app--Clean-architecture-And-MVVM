import 'package:ecommerce_app/app/extensions.dart';
import 'package:ecommerce_app/domain/model/home_object.dart';

import '../responses/home_data_response.dart';

extension on ServiceResponse {
  Service toDomain() {
    return Service(
      id: id.orZero(),
      title: title.orEmpty(),
      image: image.orEmpty(),
    );
  }
}

extension on StoreResponse {
  Store toDomain() {
    return Store(
      id: id.orZero(),
      title: title.orEmpty(),
      image: image.orEmpty(),
    );
  }
}

extension on BannerResponse {
  Banner toDomain() {
    return Banner(
      id: id.orZero(),
      title: title.orEmpty(),
      link: link.orEmpty(),
      image: image.orEmpty(),
    );
  }
}

extension on HomeDataResponse {
  HomeData toDomain() {
    return HomeData(
      services: services?.map((e) => e.toDomain()).toList() ?? [],
      stores: stores?.map((e) => e.toDomain()).toList() ?? [],
      banners: banners?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}

extension on HomeResponse {
  HomeObject toDomain() {
    return HomeObject(
      data: data?.toDomain() ??
          HomeData(
            services: [],
            stores: [],
            banners: [],
          ),
    );
  }
}
