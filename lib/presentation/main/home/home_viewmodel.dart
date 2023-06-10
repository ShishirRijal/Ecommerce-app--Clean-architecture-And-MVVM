import 'dart:async';

import 'package:ecommerce_app/presentation/presentation.dart';
import 'package:rxdart/subjects.dart';

import '../../../domain/model/home_object.dart';
import '../../../domain/usecases/home_usecase.dart';

class HomeViewModel extends BaseViewModel
    implements HomeViewModelInputs, HomeViewModelOutputs {
  final HomeUseCase _useCase;
  HomeViewModel(this._useCase);

  //* stream controllers
  final StreamController _servicesStreamController =
      BehaviorSubject<List<Service>>();
  final StreamController _bannersStreamController =
      BehaviorSubject<List<Banner>>();
  final StreamController _storesStreamController =
      BehaviorSubject<List<Store>>();

  @override
  void dispose() {
    _servicesStreamController.close();
    _bannersStreamController.close();
    _storesStreamController.close();
    super.dispose();
  }

  // ! Inputs
  @override
  getHome() {
    // TODO: implement getHome
    throw UnimplementedError();
  }

  @override
  Sink get inputBanners => _bannersStreamController.sink;

  @override
  Sink get inputServices => _servicesStreamController.sink;

  @override
  Sink get inputStores => _storesStreamController.sink;

  // ! Outputs
  @override
  Stream<List<Banner>> get outputBanners =>
      _bannersStreamController.stream.map((banners) => banners);

  @override
  Stream<List<Service>> get outputServices =>
      _servicesStreamController.stream.map((services) => services);

  @override
  Stream<List<Store>> get outputStores =>
      _storesStreamController.stream.map((stores) => stores);
}

abstract class HomeViewModelInputs {
  getHome();

  Sink get inputServices;
  Sink get inputBanners;
  Sink get inputStores;
}

abstract class HomeViewModelOutputs {
  Stream<List<Store>> get outputStores;
  Stream<List<Service>> get outputServices;
  Stream<List<Banner>> get outputBanners;
}
