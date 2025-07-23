import 'package:e_commerce_app/core/exceptions/http_exception.dart';
import 'package:e_commerce_app/core/network/model/either.dart';
import 'package:e_commerce_app/features/login/data/datasources/login_remote_data_sources.dart';
import 'package:e_commerce_app/features/login/data/models/login_request.dart';
import 'package:e_commerce_app/features/login/data/models/login_response.dart';
import 'package:e_commerce_app/features/login/data/models/user_data_model.dart';
import 'package:e_commerce_app/features/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;

  LoginRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppException,List<UserDataModel>>> getUserData() async {
    try{
      final userData = await remoteDataSource.getUserData();
      return userData;
    }catch(e){
      throw Exception('Failed to load user data : $e');
    }

  }
  @override
  Future<Either<AppException, LoginResponse>> loginUser({
    required LoginRequest user,
  }) async {
    return await remoteDataSource.login(user: user);
  }
}
