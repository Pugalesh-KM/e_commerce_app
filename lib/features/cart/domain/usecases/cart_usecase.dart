import 'package:e_commerce_app/core/exceptions/http_exception.dart';
import 'package:e_commerce_app/core/network/model/either.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_model.dart';
import 'package:e_commerce_app/features/cart/domain/repositories/cart_repository.dart';

class CartUseCase {
  final CartRepository repository;

  CartUseCase(this.repository);

  Future<Either<AppException,List<CartModel>>> getCarts() async {
    return await repository.getAllCarts();
  }
}
