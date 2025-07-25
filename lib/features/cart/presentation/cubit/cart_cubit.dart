import 'package:e_commerce_app/core/database/hive_storage_service.dart';
import 'package:e_commerce_app/core/network/model/either.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_model.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/cart_usecase.dart';
import 'package:e_commerce_app/features/product/data/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartUseCase _cartUseCase;
  final HiveService _hiveService;
  List<CartModel> _userCarts = [];
  List<ProductModel> _allProducts =[];
  List<CartItemEntity> _cartItems=[];
  double _total =0.0;

  CartCubit(this._cartUseCase)
    : _hiveService = GetIt.instance<HiveService>(),
      super(CartInitial());

  List<CartModel> get carts => _userCarts;
  List<CartItemEntity> get cartItems => _cartItems;
  double get total => _total;

  List<CartItemEntity> _mapCartModelsToCartItems(
      List<CartModel> userCarts,
      List<ProductModel> allProducts,
      ) {
    final Map<int, CartItemEntity> mergedItems = {};

    for (final cart in userCarts) {
      for (final item in cart.products) {
        final product = allProducts.firstWhere(
              (p) => p.id == item.productId,
          orElse: () => ProductModel(
            id: 0,
            title: 'Unknown',
            price: 0.0,
            description: '',
            category: Category.ELECTRONICS,
            image: '',
          ),
        );

        if (mergedItems.containsKey(item.productId)) {
          final existing = mergedItems[item.productId]!;
          mergedItems[item.productId] = CartItemEntity(
            product: product,
            quantity: existing.quantity + item.quantity,
          );
        } else {
          mergedItems[item.productId] = CartItemEntity(
            product: product,
            quantity: item.quantity,
          );
        }
      }
    }

    return mergedItems.values.toList();
  }

  Future<void> fetchCarts(List<ProductModel> products) async {
    emit(CartLoading());
    _allProducts = products;


    if (!_hiveService.hasInitialized) {
      await _hiveService.init();
    }
    int userId = await _hiveService.getUserId();
    Either result = await _cartUseCase.getCarts();

    result.fold(
      (failure) {
        emit(CartError(failure.message));
      },
      (carts) {
        _userCarts = carts.where((cart) => cart.userId == userId).toList();
        _cartItems = _mapCartModelsToCartItems(_userCarts, _allProducts);
        _total = _cartItems.fold<double>(0, (sum, item) => sum + item.totalPrice);
        emit(CartSuccess(_userCarts,_cartItems,_total));
      },
    );
  }

  Future<void> logOut() async{
    _userCarts.clear();
    _cartItems.clear();
    _total = 0.0;
    emit(CartInitial());
  }
}
