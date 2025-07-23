import 'package:e_commerce_app/shared/config/dimens.dart';
import 'package:e_commerce_app/shared/theme/app_colors.dart';
import 'package:e_commerce_app/shared/theme/text_styles.dart';
import 'package:flutter/material.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/empty_cart.png',
            height: 160,
          ),
          const SizedBox(height: Dimens.standard_20),
          Text(
            "Your cart is empty",
            style: AppTextStyles.openSansBold18.copyWith(
              color: AppColors.color263238,
            ),
          ),
          const SizedBox(height: Dimens.standard_8),
          Text(
            "Add items to get started!",
            style: AppTextStyles.openSansRegular14.copyWith(
              color: AppColors.color707070,
            ),
          ),
        ],
      ),
    );
  }
}
