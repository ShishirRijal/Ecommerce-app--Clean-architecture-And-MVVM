import 'package:ecommerce_app/app/extensions.dart';
import 'package:ecommerce_app/domain/model/home_object.dart';

import '../responses/home_data_response.dart';

extension on ServiceResponse? {
  Service toDomain() {
    return Service(
      id: this?.id?.orZero() ?? 0,
      title: this?.title.orEmpty() ?? '',
      image: this?.image.orEmpty() ?? '',
    );
  }
}

extension on StoreResponse? {
  Store toDomain() {
    return Store(
      id: this?.id.orZero() ?? 0,
      title: this?.title.orEmpty() ?? '',
      image: this?.image.orEmpty() ?? '',
    );
  }
}

extension on BannerResponse? {
  Banner toDomain() {
    return Banner(
      id: this?.id.orZero() ?? 0,
      title: this?.title.orEmpty() ?? '',
      link: this?.link.orEmpty() ?? '',
      image: this?.image.orEmpty() ?? '',
    );
  }
}

extension on HomeDataResponse? {
  HomeData toDomain() {
    return HomeData(
      services: this?.services?.map((e) => e.toDomain()).toList() ?? [],
      stores: this?.stores?.map((e) => e.toDomain()).toList() ?? [],
      banners: this?.banners?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    return HomeObject(
      data: this?.data?.toDomain() ??
          HomeData(
            services: [],
            stores: [],
            banners: [],
          ),
    );
  }
}
