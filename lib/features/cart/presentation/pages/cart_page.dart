import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/cart_product_card_view.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/empty_cart.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/total_cart.dart';
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
    final cartCubit = context.read<CartCubit>();
    if (cartCubit.state is CartInitial) {
      final productState = context.read<ProductCubit>().state;
      if (productState is ProductSuccess) {
        context.read<CartCubit>().fetchCarts(productState.products);
      }
    }
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
          if (cartState is CartSuccess) {
            final cart = cartState.carts;
            if (cart.isEmpty) {
              return EmptyCart();
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.standard_6,
                    ),
                    itemCount: cartState.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartState.cartItems[index];
                      return CartProductCardView(
                        product: item.product,
                        quantity: item.quantity,
                        price: item.product.price * item.quantity,
                      );
                    },
                  ),
                ),
                TotalCart(total: cartState.total),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
