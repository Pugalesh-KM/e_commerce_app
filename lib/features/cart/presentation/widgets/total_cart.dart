import 'package:e_commerce_app/shared/config/dimens.dart';
import 'package:e_commerce_app/shared/theme/app_colors.dart';
import 'package:e_commerce_app/shared/theme/text_styles.dart';
import 'package:flutter/material.dart';

class TotalCart extends StatelessWidget {
  const TotalCart({super.key, required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimens.standard_16),
      decoration: BoxDecoration(
        color: AppColors.colorWhite,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(Dimens.standard_16),
          topRight: Radius.circular(Dimens.standard_16),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total:",
                style: AppTextStyles.openSansSemiBold16.copyWith(
                  color: AppColors.color263238,
                ),
              ),
              Text(
                "₹${total.toStringAsFixed(2)}",
                style: AppTextStyles.openSansBold18.copyWith(
                  color: AppColors.color04D100,
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimens.standard_12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.payment),
              label: Text(
                "Proceed to Checkout",
                style: AppTextStyles.openSansSemiBold16.copyWith(
                  color: AppColors.colorWhite,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.colorPrimary,
                padding: const EdgeInsets.symmetric(
                  vertical: Dimens.standard_14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimens.standard_12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
