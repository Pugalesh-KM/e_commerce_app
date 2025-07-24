import 'package:e_commerce_app/core/database/hive_storage_service.dart';
import 'package:e_commerce_app/core/network/model/either.dart';
import 'package:e_commerce_app/features/product/domain/entities/product_entity.dart';
import 'package:e_commerce_app/features/product/domain/usecases/product_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductUseCase _productUseCase;
  final HiveService _hiveService;
  List<ProductEntity> _allProducts = [];
  Category? _selectedCategory;

  ProductCubit(this._productUseCase)
    : _hiveService = GetIt.instance<HiveService>(),
      super(ProductInitial()) {
    fetchProducts();
  }

  Future<void> logOut() async {
    await _hiveService.clear();
    emit(ProductInitial());
  }
  Future<void> fetchProducts() async {
    emit(ProductLoading());

    Either result = await _productUseCase.getProducts();
    result.fold(
      (failure) {
        emit(ProductError(failure.message));
      },
      (products) {
        _allProducts = products;
        emit(ProductLoaded(products));
        emit(ProductSuccess(products, _selectedCategory));
      },
    );
  }

  void filterByCategory(Category? category) {
    _selectedCategory = category;
    if (category == null) {
      emit(ProductSuccess(_allProducts, null));
    } else {
      final filtered = _allProducts
          .where((p) => p.category == category)
          .toList();
      emit(ProductSuccess(filtered));
    }
  }

  Category? get selectedCategory => _selectedCategory;
}
