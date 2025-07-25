import 'package:e_commerce_app/features/product/data/models/product_model.dart';
import 'package:e_commerce_app/shared/config/dimens.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/shared/theme/app_colors.dart';
import 'package:e_commerce_app/shared/theme/text_styles.dart';

class ProductCardView extends StatelessWidget {
  final ProductModel product;

  const ProductCardView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: AppColors.colorWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.standard_16),
        side: BorderSide(color: AppColors.colorSecondaryLight),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Dimens.standard_8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Expanded(
              child: Center(
                child: Image.network(
                  product.image,
                  fit: BoxFit.contain,
                  height: Dimens.standard_100,
                  errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                ),
              ),
            ),
            const SizedBox(height: Dimens.standard_8),

            // Product Title
            Text(
              product.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.openSansSemiBold16.copyWith(
                color: AppColors.colorPrimary,
              ),
            ),

            const SizedBox(height: Dimens.standard_4),

            // Product Price
            Text(
              '₹${product.price.toStringAsFixed(2)}',
              style: AppTextStyles.openSansRegular14.copyWith(
                color: AppColors.color04D100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
