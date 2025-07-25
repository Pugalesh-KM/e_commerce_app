part of 'product_cubit.dart';

abstract class ProductState{}

class ProductInitial extends ProductState{}

class ProductLoading extends ProductState{}


class ProductSuccess extends ProductState{
  final List<ProductModel> products;
  final Category? selectedCategory;
  ProductSuccess(this.products,[this.selectedCategory]);
}


class ProductError extends ProductState{
  final String error;
  ProductError(this.error);
}