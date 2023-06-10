import '../responses/home_data_response.dart';
import '../responses/store_detail_response.dart';

abstract class LocalDataSource {
  Future<HomeResponse> getHome();
  Future<void> saveHomeToCache(HomeResponse homeResponse);
  Future<StoreDetailResponse> getStoreDetails();
  Future<void> saveStoreDetailsToCache(StoreDetailResponse response);

  void clearCache();
  void removeFromCache(String key);
}
