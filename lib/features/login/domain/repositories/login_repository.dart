import 'package:e_commerce_app/core/exceptions/http_exception.dart';
import 'package:e_commerce_app/core/network/model/either.dart';
import 'package:e_commerce_app/features/login/data/models/login_request.dart';
import 'package:e_commerce_app/features/login/data/models/login_response.dart';
import 'package:e_commerce_app/features/login/data/models/user_data_model.dart';


abstract class LoginRepository{
  Future<Either<AppException,LoginResponse>> loginUser( {required LoginRequest user});

  Future<Either<AppException,List<UserDataModel>>> getUserData();
}