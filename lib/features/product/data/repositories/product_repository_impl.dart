import 'package:e_commerce_app/core/exceptions/http_exception.dart';
import 'package:e_commerce_app/core/network/model/either.dart';
import 'package:e_commerce_app/features/product/data/datasources/product_remote_data_source.dart';
import 'package:e_commerce_app/features/product/domain/entities/product_entity.dart';
import 'package:e_commerce_app/features/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository{
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppException,List<ProductEntity>>> getAllProducts() async {
    try{
      final products = await remoteDataSource.getAllProducts();
      return products;
    }catch(e){
      throw Exception('Failed to load products: $e');
    }

  }

}