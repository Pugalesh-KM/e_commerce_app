

import 'package:e_commerce_app/features/product/data/models/product_model.dart';

class CartItemEntity {
  final ProductModel product;
  final int quantity;

  CartItemEntity({
    required this.product,
    required this.quantity,
  });

  double get totalPrice => product.price * quantity;
}
