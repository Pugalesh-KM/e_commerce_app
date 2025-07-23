import 'package:e_commerce_app/shared/config/dimens.dart';
import 'package:flutter/material.dart';

class GridViewProducts extends StatelessWidget {
  const GridViewProducts({super.key, required this.itemCount, required this.itemBuilder});

  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: Dimens.standard_4, vertical: Dimens.standard_4),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: Dimens.standard_8,
        mainAxisSpacing: Dimens.standard_2,
        childAspectRatio: Dimens.decimal_9,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
