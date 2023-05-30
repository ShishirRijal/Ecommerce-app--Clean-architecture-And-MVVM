import 'package:ecommerce_app/app/app_prefs.dart';
import 'package:ecommerce_app/data/data.dart';
import 'package:ecommerce_app/data/data_source/remote_data_source.dart';
import 'package:ecommerce_app/data/data_source/remote_data_source_impl.dart';
import 'package:ecommerce_app/domain/repositories/auth_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/network/network_info_implementer.dart';
import '../domain/usecases/login_usecase.dart';
import '../presentation/login/login_viewmodel.dart';

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
  // auth repo
  getIt.registerLazySingleton<AuthRepository>(() =>
      AuthRepositoryImpl(networkInfo: getIt(), remoteDataSource: getIt()));
}

void initLogin() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    getIt.registerFactory(() => LoginUseCase(getIt()));
    getIt.registerFactory(() => LoginViewModel(loginUseCase: getIt()));
  }
}
