import 'package:e_commerce_app/core/exceptions/http_exception.dart';
import 'package:e_commerce_app/core/network/model/either.dart';
import 'package:e_commerce_app/features/product/domain/entities/product_entity.dart';
import 'package:e_commerce_app/features/product/domain/repositories/product_repository.dart';

class ProductUseCase {
  final ProductRepository repository;

  ProductUseCase(this.repository);

  Future<Either<AppException,List<ProductEntity>>> getProducts() async {
    return await repository.getAllProducts();
  }
}
