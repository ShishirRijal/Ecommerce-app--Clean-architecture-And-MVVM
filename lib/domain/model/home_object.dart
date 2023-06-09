class Service {
  final int id;
  final String title;
  final String image;

  Service({
    required this.id,
    required this.title,
    required this.image,
  });
}

class Store {
  final int id;
  final String title;
  final String image;

  Store({
    required this.id,
    required this.title,
    required this.image,
  });
}

class Banner {
  final int id;
  final String title;
  final String link;
  final String image;

  Banner({
    required this.id,
    required this.title,
    required this.link,
    required this.image,
  });
}

// home data
class HomeData {
  final List<Service> services;
  final List<Store> stores;
  final List<Banner> banners;

  HomeData({
    required this.services,
    required this.stores,
    required this.banners,
  });
}

// home object
class HomeObject {
  final HomeData data;

  HomeObject({
    required this.data,
  });
}
