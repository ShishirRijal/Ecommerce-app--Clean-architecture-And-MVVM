import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/data/data.dart';
import 'package:ecommerce_app/domain/model/model.dart';
import 'package:ecommerce_app/domain/repositories/auth_repository.dart';
import 'package:ecommerce_app/domain/usecases/usecases.dart';

class RegisterUseCase
    extends BaseUseCase<RegisterUseCaseInput, Authentication> {
  final AuthRepository _authRepository;
  RegisterUseCase(this._authRepository);

  @override
  Future<Either<Failure, Authentication>> call(
      RegisterUseCaseInput params) async {
    // Device device = await getDeviceInfo();
    return await _authRepository.register(RegisterRequest(
      email: params.email,
      password: params.password,
      countryMobileCode: params.countryMobileCode,
      mobileNumber: params.mobileNumber,
      profilePicture: params.profilePicture,
      username: params.username,
    ));
  }
}

class RegisterUseCaseInput {
  String email;
  String password;
  String countryMobileCode;
  String mobileNumber;
  String profilePicture;
  String username;
  RegisterUseCaseInput({
    required this.username,
    required this.profilePicture,
    required this.mobileNumber,
    required this.countryMobileCode,
    required this.email,
    required this.password,
  });
}
