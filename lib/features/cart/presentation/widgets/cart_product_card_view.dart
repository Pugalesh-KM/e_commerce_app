import 'package:e_commerce_app/features/product/domain/entities/product_entity.dart';
import 'package:e_commerce_app/shared/config/dimens.dart';
import 'package:e_commerce_app/shared/theme/app_colors.dart';
import 'package:e_commerce_app/shared/theme/text_styles.dart';
import 'package:flutter/material.dart';

class CartProductCardView extends StatelessWidget {
  const CartProductCardView({
    super.key, required this.product, required this.quantity, required this.price,
  });

  final ProductEntity product;
  final int quantity;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.standard_12),
      ),
      elevation: 2,
      color: AppColors.colorWhite,
      margin: const EdgeInsets.symmetric(vertical: Dimens.standard_4),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: Dimens.standard_8),
        leading: ClipRRect(
          child: Image.network(
            product.image,
            width: Dimens.standard_60,
            height: Dimens.standard_60,
            fit: BoxFit.fill,
          ),
        ),
        title: Text(
          product.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.openSansSemiBold16.copyWith(
            color: AppColors.color1F2155,
          ),
        ),
        subtitle: Text(
          "Quantity: $quantity",
          style: AppTextStyles.openSansRegular14.copyWith(
            color: AppColors.color707070,
          ),
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "₹${product.price.toStringAsFixed(2)}",
              style: AppTextStyles.openSansRegular14.copyWith(
                color: AppColors.color4F4F4F,
              ),
            ),
            Text(
              "₹${price.toStringAsFixed(2)}",
              style: AppTextStyles.openSansBold16.copyWith(
                color: AppColors.colorPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
