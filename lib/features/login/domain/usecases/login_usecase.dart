import 'package:e_commerce_app/core/exceptions/http_exception.dart';
import 'package:e_commerce_app/core/network/model/either.dart';
import 'package:e_commerce_app/features/login/data/models/login_request.dart';
import 'package:e_commerce_app/features/login/data/models/login_response.dart';
import 'package:e_commerce_app/features/login/data/models/user_data_model.dart';
import 'package:e_commerce_app/features/login/domain/repositories/login_repository.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase(this.repository);

  Future<Either<AppException,List<UserDataModel>>> getUserData() async {
    return await repository.getUserData();
  }

  Future<Either<AppException,LoginResponse>> login({
    required LoginRequest user,
  }) async{
    return await repository.loginUser(user: user);
  }
}
