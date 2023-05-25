import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/app/helper_functions.dart';
import 'package:ecommerce_app/data/data.dart';
import 'package:ecommerce_app/domain/model/model.dart';
import 'package:ecommerce_app/domain/repositories/auth_repository.dart';
import 'package:ecommerce_app/domain/usecases/usecases.dart';

class LoginUseCase extends BaseUseCase<LoginUseCaseInput, Authentication> {
  final AuthRepository _authRepository;
  LoginUseCase(this._authRepository);

  @override
  Future<Either<Failure, Authentication>> call(LoginUseCaseInput params) async {
    Device device = await getDeviceInfo();
    return await _authRepository.login(LoginRequest(
      email: params.email,
      password: params.password,
      imei: device.identifier,
      deviceName: device.name,
    ));
  }
}

class LoginUseCaseInput {
  String email;
  String password;
  LoginUseCaseInput({
    required this.email,
    required this.password,
  });
}
