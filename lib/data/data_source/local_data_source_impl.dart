import 'package:ecommerce_app/data/data.dart';
import 'package:ecommerce_app/data/data_source/local_data_source.dart';
import 'package:ecommerce_app/data/responses/home_data_response.dart';

const cacheHomeKey = 'CACHE_HOME_KEY';
const cacheHomeInterval = 60 * 1000; // 1 minute

class LocalDataSourceImpl extends LocalDataSource {
  // run time cache
  Map<String, CacheItem> cacheMap = {};

  @override
  Future<HomeResponse> getHome() {
    CacheItem? cacheItem = cacheMap[cacheHomeKey];
    if (cacheItem != null && cacheItem.isValid) {
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
  bool get isValid {
    return DateTime.now().millisecondsSinceEpoch - cacheHomeInterval <
        cacheTime;
  }
}
