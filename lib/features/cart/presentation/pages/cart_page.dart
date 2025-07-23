
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/cart_product_card_view.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/empty_cart.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/total_cart.dart';
import 'package:e_commerce_app/features/product/data/models/product_model.dart';
import 'package:e_commerce_app/features/product/domain/entities/product_entity.dart';
import 'package:e_commerce_app/features/product/presentation/cubit/product_cubit.dart';
import 'package:e_commerce_app/shared/config/dimens.dart';
import 'package:e_commerce_app/shared/theme/app_colors.dart';
import 'package:e_commerce_app/shared/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackGround,
      appBar: AppBar(
        backgroundColor: AppColors.colorWhite,
        elevation: 1,
        title: Text(
          "Your Cart",
          style: AppTextStyles.openSansBold18.copyWith(
            color: AppColors.color1F2155,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: AppColors.colorRed,
              ),
            );
          }
        },
        builder: (context, cartState) {
          if (cartState is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (cartState is CartError) {
            return Center(
              child: Text(
                cartState.error,
                style: AppTextStyles.openSansRegular14.copyWith(
                  color: AppColors.colorRed,
                ),
              ),
            );
          }

          if (cartState is CartLoaded) {
            final productState = context.read<ProductCubit>().state;

            if (productState is! ProductSuccess) {
              return Center(
                child: Text(
                  "Product data not loaded",
                  style: AppTextStyles.openSansRegular14,
                ),
              );
            }

            final allProducts = productState.products;
            final cart = cartState.carts;

            if (cart.isEmpty || cart.every((c) => c.products.isEmpty)) {
              return EmptyCart();
            }

            final cartItems = cart.expand((cartModel) {
              return cartModel.products.map((cartItem) {
                final product = allProducts.firstWhere(
                      (p) => p.id == cartItem.productId,
                  orElse: () => ProductModel(
                    id: 0,
                    title: 'Unknown',
                    price: 0.0,
                    description: '',
                    category: Category.ELECTRONICS,
                    image: '',
                  ),
                );
                return {'product': product, 'quantity': cartItem.quantity};
              });
            }).toList();

            final total = cartItems.fold<double>(0, (sum, item) => sum + (item['product'] as ProductEntity).price * (item['quantity'] as int),);

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.standard_6,),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      final product = item['product'] as ProductEntity;
                      final quantity = item['quantity'] as int;
                      final price = product.price * quantity;

                      return CartProductCardView(product: product, quantity: quantity, price: price);
                    },
                  ),
                ),
                TotalCart(total: total),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
