

import 'package:e_commerce_app/core/exceptions/http_exception.dart';
import 'package:e_commerce_app/core/network/model/either.dart';
import 'package:e_commerce_app/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_model.dart';
import 'package:e_commerce_app/features/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImpl extends CartRepository{
  final CartRemoteDataSource remoteDataSource;

  CartRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppException,List<CartModel>>> getAllCarts() async {
    try{
      final products = await remoteDataSource.getAllCarts();
      return products;
    }catch(e){
      throw Exception('Failed to load products: $e');
    }

  }

}