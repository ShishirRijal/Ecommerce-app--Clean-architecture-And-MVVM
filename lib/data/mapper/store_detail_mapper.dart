import 'package:ecommerce_app/app/extensions.dart';

import '../../domain/model/store_detail.dart';
import '../responses/store_detail_response.dart';

extension StoreDetailResponseMapper on StoreDetailResponse? {
  StoreDetail toDomain() {
    return StoreDetail(
        this?.id?.orZero() ?? 0,
        this?.title?.orEmpty() ?? "",
        this?.image?.orEmpty() ?? "",
        this?.details?.orEmpty() ?? "",
        this?.services?.orEmpty() ?? "",
        this?.about?.orEmpty() ?? "");
  }
}
