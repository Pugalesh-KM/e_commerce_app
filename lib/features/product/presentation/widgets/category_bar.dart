import 'package:flutter/material.dart';
import 'package:e_commerce_app/shared/theme/app_colors.dart';
import 'package:e_commerce_app/shared/theme/text_styles.dart';
import '../../domain/entities/product_entity.dart';

class CategoryBar extends StatelessWidget {
  final Category? selectedCategory;
  final Function(Category?) onCategorySelected;

  const CategoryBar({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final categories = [
      null,
      Category.MEN_S_CLOTHING,
      Category.WOMEN_S_CLOTHING,
      Category.ELECTRONICS,
      Category.JEWELERY,
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: categories.map((category) {
          final isSelected = selectedCategory == category;
          final label = category == null
              ? 'All'
              : category.name.toLowerCase().replaceAll('_', ' ');

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: ChoiceChip(
              elevation: isSelected ? 4 : 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              label: Text(
                label,
                style: AppTextStyles.openSansSemiBold16.copyWith(
                  color: isSelected
                      ? AppColors.colorWhite
                      : AppColors.colorPrimary,
                ),
              ),
              selected: isSelected,
              onSelected: (_) => onCategorySelected(category),
              selectedColor: AppColors.colorPrimary,
              backgroundColor: AppColors.colorSecondaryLight,
              checkmarkColor: AppColors.colorWhite,
            ),
          );
        }).toList(),
      ),
    );
  }
}
