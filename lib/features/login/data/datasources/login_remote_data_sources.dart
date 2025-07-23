import 'package:e_commerce_app/core/constants/api_constants.dart';
import 'package:e_commerce_app/core/exceptions/http_exception.dart';
import 'package:e_commerce_app/core/network/model/either.dart';
import 'package:e_commerce_app/core/network/network_service.dart';
import 'package:e_commerce_app/features/login/data/models/login_request.dart';
import 'package:e_commerce_app/features/login/data/models/login_response.dart';
import 'package:e_commerce_app/features/login/data/models/user_data_model.dart';

abstract class LoginRemoteDataSource {
  Future<Either<AppException, LoginResponse>> login({
    required LoginRequest user,
  });

  Future<Either<AppException,List<UserDataModel>>> getUserData();
}

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  final NetworkService networkService;

  LoginRemoteDataSourceImpl(this.networkService);

  @override
  Future<Either<AppException, List<UserDataModel>>> getUserData() async {
    try {
      Either eitherType = await networkService.get(ApiConstants.users);
      return eitherType.fold(
            (exception) {
          return Left(exception);
        },
            (response) {
          final List data = response.data;
          final userData = data.map((e) => UserDataModel.fromJson(e)).toList();
          return Right(userData);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          message: e.toString(),
          statusCode: 1,
          identifier:'${e.toString()}\nLoginRemoteDataSource.getUserData',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, LoginResponse>> login({
    required LoginRequest user,
  }) async {
    try {
      Either eitherType = await networkService.post(
        ApiConstants.login,
        data: user.toJson(),
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          LoginResponse user = LoginResponse.fromJson(response.data);
          networkService.updateHeader({'x-access-token': user.token});
          return Right(user);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occurred',
          statusCode: 1,
          identifier: '${e.toString()}\nLoginRemoteDataSource.loginUser',
        ),
      );
    }
  }
}
