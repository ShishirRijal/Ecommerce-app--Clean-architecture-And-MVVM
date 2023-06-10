import 'dart:ffi';

import 'package:ecommerce_app/presentation/presentation.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/model/store_detail.dart';
import '../../domain/usecases/store_detail_usecase.dart';
import '../common/state_renderer/state_render_implementer.dart';
import '../common/state_renderer/state_renderer.dart';

class StoreDetailViewModel extends BaseViewModel
    with StoreDetailViewModelInput, StoreDetailViewModelOutput {
  final _storeDetailsStreamController = BehaviorSubject<StoreDetail>();

  final StoreDetailUseCase storeDetailUseCase;

  StoreDetailViewModel(this.storeDetailUseCase);

  @override
  start() async {
    _loadData();
  }

  _loadData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await storeDetailUseCase(Void)).fold(
      (failure) {
        inputState.add(ErrorState(
            StateRendererType.fullScreenErrorState, failure.message));
      },
      (storeDetails) async {
        inputState.add(ContentState());
        inputStoreDetails.add(storeDetails);
      },
    );
  }

  @override
  void dispose() {
    _storeDetailsStreamController.close();
  }

  @override
  Sink get inputStoreDetails => _storeDetailsStreamController.sink;

  //output
  @override
  Stream<StoreDetail> get outputStoreDetails =>
      _storeDetailsStreamController.stream.map((stores) => stores);
}

abstract class StoreDetailViewModelInput {
  Sink get inputStoreDetails;
}

abstract class StoreDetailViewModelOutput {
  Stream<StoreDetail> get outputStoreDetails;
}
