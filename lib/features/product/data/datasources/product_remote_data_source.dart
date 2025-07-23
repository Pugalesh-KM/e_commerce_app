import 'package:e_commerce_app/core/constants/api_constants.dart';
import 'package:e_commerce_app/core/exceptions/http_exception.dart';
import 'package:e_commerce_app/core/network/model/either.dart';
import 'package:e_commerce_app/core/network/network_service.dart';
import 'package:e_commerce_app/features/product/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<Either<AppException, List<ProductModel>>> getAllProducts();
}

class ProductRemoteDataSourceImpl extends ProductRemoteDataSource {
  final NetworkService networkService;

  ProductRemoteDataSourceImpl(this.networkService);

  @override
  Future<Either<AppException, List<ProductModel>>> getAllProducts() async {
    try {
      Either eitherType = await networkService.get(ApiConstants.products);
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final List data = response.data;
          final products = data.map((e) => ProductModel.fromJson(e)).toList();
          return Right(products);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occurred',
          statusCode: 1,
          identifier: '${e.toString()}\nProductRemoteDataSource.getAllProducts',
        ),
      );
    }
  }
}
