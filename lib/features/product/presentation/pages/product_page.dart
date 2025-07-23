import 'package:e_commerce_app/core/constants/routes.dart';
import 'package:e_commerce_app/features/product/presentation/cubit/product_cubit.dart';
import 'package:e_commerce_app/features/product/presentation/widgets/category_bar.dart';
import 'package:e_commerce_app/features/product/presentation/widgets/product_card_view.dart';
import 'package:e_commerce_app/shared/config/dimens.dart';
import 'package:e_commerce_app/shared/theme/app_colors.dart';
import 'package:e_commerce_app/shared/theme/text_styles.dart';
import 'package:e_commerce_app/shared/widgets/grid_view_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductCubit>();

    return Scaffold(
      backgroundColor: AppColors.appBackGround,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: AppColors.colorWhite,
        title: Text(
          'Store Products',
          style: AppTextStyles.openSansSemiBold16.copyWith(
            color: AppColors.colorPrimary,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => context.push(RoutesName.cartPath),
            icon: const Icon(Icons.shopping_cart_outlined),
            color: AppColors.colorPrimary,
          ),
        ],
      ),
      body: BlocConsumer<ProductCubit, ProductState>(
        listenWhen: (previous, current) => current is ProductError,
        listener: (context, state) {
          if (state is ProductError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.error,
                  style: AppTextStyles.openSansRegular14.copyWith(
                    color: AppColors.colorWhite,
                  ),
                ),
                backgroundColor: AppColors.colorRed,
              ),
            );
          }
        },
        buildWhen: (previous, current) =>
        current is ProductSuccess || current is ProductLoading,
        builder: (context, state) {
          final selectedCategory = cubit.selectedCategory;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.standard_12,
                  vertical: Dimens.standard_4,
                ),
                child: Text(
                  "Categories",
                  style: AppTextStyles.openSansSemiBold16.copyWith(
                    color: AppColors.colorBlack,
                  ),
                ),
              ),
              CategoryBar(
                selectedCategory: selectedCategory,
                onCategorySelected: cubit.filterByCategory,
              ),
              Expanded(child: _buildProductGrid(state)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProductGrid(ProductState state) {
    if (state is ProductLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.colorPrimary,
        ),
      );
    } else if (state is ProductSuccess) {
      final products = state.products;
      if (products.isEmpty) {
        return const Center(
          child: Text(
            "No products found in this category.",
            style: AppTextStyles.openSansRegular14,
          ),
        );
      }
      return GridViewProducts(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCardView(product: product);
        },
      );
    }

    return const Center(
      child: Text(
        "Unable to load products.",
        style: AppTextStyles.openSansRegular14,
      ),
    );
  }
}
