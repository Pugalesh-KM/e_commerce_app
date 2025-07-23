import 'package:e_commerce_app/core/constants/api_constants.dart';
import 'package:e_commerce_app/core/exceptions/http_exception.dart';
import 'package:e_commerce_app/core/network/model/either.dart';
import 'package:e_commerce_app/core/network/network_service.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_model.dart';


abstract class CartRemoteDataSource {
  Future<Either<AppException, List<CartModel>>> getAllCarts();
}

class CartRemoteDataSourceImpl extends CartRemoteDataSource {
  final NetworkService networkService;

  CartRemoteDataSourceImpl(this.networkService);

  @override
  Future<Either<AppException, List<CartModel>>> getAllCarts() async {
    try {
      Either eitherType = await networkService.get(ApiConstants.carts);
      return eitherType.fold(
            (exception) {
          return Left(exception);
        },
            (response) {
          final List data = response.data;
          final carts = data.map((e) => CartModel.fromJson(e)).toList();
          return Right(carts);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occurred',
          statusCode: 1,
          identifier: '${e.toString()}\nCartRemoteDataSource.getAllCarts',
        ),
      );
    }
  }
}
