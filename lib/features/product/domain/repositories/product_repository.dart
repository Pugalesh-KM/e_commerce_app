import 'package:e_commerce_app/core/exceptions/http_exception.dart';
import 'package:e_commerce_app/core/network/model/either.dart';
import 'package:e_commerce_app/features/product/data/models/product_model.dart';

abstract class ProductRepository{

  Future<Either<AppException,List<ProductModel>>> getAllProducts();
}