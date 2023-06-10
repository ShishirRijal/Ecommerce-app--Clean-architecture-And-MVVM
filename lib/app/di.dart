import 'package:ecommerce_app/app/app_prefs.dart';
import 'package:ecommerce_app/data/data.dart';
import 'package:ecommerce_app/data/data_source/local_data_source.dart';
import 'package:ecommerce_app/data/data_source/local_data_source_impl.dart';
import 'package:ecommerce_app/data/repository_impl/store_detail_repository_impl.dart';
import 'package:ecommerce_app/domain/repositories/respositories.dart';
import 'package:ecommerce_app/domain/repositories/store_detail_repository.dart';
import 'package:ecommerce_app/domain/usecases/forgot_password_usecase.dart';
import 'package:ecommerce_app/domain/usecases/register_usecase.dart';
import 'package:ecommerce_app/presentation/forgot_password/forgot_password_viewmodel.dart';
import 'package:ecommerce_app/presentation/register/register_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/network/network_info_implementer.dart';
import '../data/repository_impl/home_repository_impl.dart';
import '../domain/repositories/home_repository.dart';
import '../domain/usecases/home_usecase.dart';
import '../domain/usecases/login_usecase.dart';
import '../domain/usecases/store_detail_usecase.dart';
import '../presentation/login/login_viewmodel.dart';
import '../presentation/main/home/home_viewmodel.dart';
import '../presentation/store_detail/store_detail_viewmodel.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  // for shared preferences
  final sharedPrefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  getIt.registerLazySingleton<AppPreferences>(() => AppPreferences(getIt()));

  // network info
  getIt.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImplementer(InternetConnectionChecker()));
  // dio factor
  getIt.registerLazySingleton<DioFactory>(() => DioFactory(getIt()));
  // app service client
  final dio = await getIt<DioFactory>().getDio();
  getIt.registerLazySingleton(() => AppServiceClient(dio));
  // remote data soruce
  getIt.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(getIt()));
  // local data soruce
  getIt.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());
  // auth repo
  getIt.registerLazySingleton<AuthRepository>(() =>
      AuthRepositoryImpl(networkInfo: getIt(), remoteDataSource: getIt()));
  getIt.registerLazySingleton<ForgotPasswordRepository>(() =>
      ForgotPasswordRepositoryImpl(
          networkInfo: getIt(), remoteDataSource: getIt()));
  getIt.registerLazySingleton<StoreDetailRepository>(
      () => StoreDetailRepositoryImpl(
            networkInfo: getIt(),
            remoteDataSource: getIt(),
            localDataSource: getIt(),
          ));
  getIt.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(
        networkInfo: getIt(),
        remoteDataSource: getIt(),
        localDataSource: getIt(),
      ));
}

void initLogin() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    getIt.registerFactory(() => LoginUseCase(getIt()));
    getIt.registerFactory(() => LoginViewModel(loginUseCase: getIt()));
  }
}

void initForgotPassword() {
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    getIt.registerFactory(() => ForgotPasswordUseCase(getIt()));
    getIt.registerFactory(() => ForgotPasswordViewModel(getIt()));
  }
}

void initRegister() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    getIt.registerFactory(() => RegisterUseCase(getIt()));
    getIt.registerFactory<ImagePicker>(() => ImagePicker());
    getIt.registerFactory(() => RegisterViewModel(getIt()));
  }
}

void initHome() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    getIt.registerFactory(() => HomeUseCase(getIt()));
    getIt.registerFactory(() => HomeViewModel(getIt()));
  }
}

void initStoreDetail() {
  if (!GetIt.I.isRegistered<StoreDetailUseCase>()) {
    getIt
        .registerFactory<StoreDetailUseCase>(() => StoreDetailUseCase(getIt()));
    getIt.registerFactory<StoreDetailViewModel>(
        () => StoreDetailViewModel(getIt()));
  }
}
