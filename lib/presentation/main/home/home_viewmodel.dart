import 'dart:async';

import 'package:ecommerce_app/presentation/presentation.dart';
import 'package:rxdart/subjects.dart';

import '../../../domain/model/home_object.dart';
import '../../../domain/usecases/home_usecase.dart';

class HomeViewModel extends BaseViewModel {
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
}
