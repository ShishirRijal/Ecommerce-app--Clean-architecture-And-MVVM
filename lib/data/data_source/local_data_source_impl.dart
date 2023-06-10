import 'package:ecommerce_app/data/data.dart';
import 'package:ecommerce_app/data/data_source/local_data_source.dart';
import 'package:ecommerce_app/data/responses/home_data_response.dart';

import '../responses/store_detail_response.dart';

const cacheHomeKey = 'CACHE_HOME_KEY';
const cacheHomeInterval = 60 * 1000; // 1 minute
const cacheStoreDetailkey = "CACHE_STORE_DETAILS_KEY";
const cacheStoreDetailInterval = 60 * 1000; //

class LocalDataSourceImpl extends LocalDataSource {
  // run time cache
  Map<String, CacheItem> cacheMap = {};

  @override
  Future<HomeResponse> getHome() {
    CacheItem? cacheItem = cacheMap[cacheHomeKey];
    if (cacheItem != null && cacheItem.isValid(cacheHomeInterval)) {
      // return response from cache
      return Future.value(cacheItem.data);
    }
    // throw error
    throw ErrorHandler.handle(StatusCode.CACHE_ERROR);
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheMap[cacheHomeKey] = CacheItem(homeResponse);
  }

  @override
  Future<StoreDetailResponse> getStoreDetails() async {
    CacheItem? cacheItem = cacheMap[cacheStoreDetailkey];

    if (cacheItem != null && cacheItem.isValid(cacheStoreDetailInterval)) {
      return cacheItem.data;
    } else {
      throw ErrorHandler.handle(StatusCode.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveStoreDetailsToCache(StoreDetailResponse response) async {
    cacheMap[cacheStoreDetailkey] = CacheItem(response);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }
}

// * Cache Item
class CacheItem {
  final dynamic data;
  final int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CacheItem(this.data);
}

extension on CacheItem {
  bool isValid(int expireTime) {
    return DateTime.now().millisecondsSinceEpoch - expireTime < cacheTime;
  }
}
