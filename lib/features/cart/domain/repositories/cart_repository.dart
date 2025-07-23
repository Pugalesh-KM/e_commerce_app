import 'package:e_commerce_app/core/exceptions/http_exception.dart';
import 'package:e_commerce_app/core/network/model/either.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_model.dart';

abstract class CartRepository{

  Future<Either<AppException,List<CartModel>>> getAllCarts();
}