import 'dart:developer';

import 'package:e_commerce_app/core/database/hive_storage_service.dart';
import 'package:e_commerce_app/core/network/model/either.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_model.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/cart_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartUseCase _cartUseCase;
  final HiveService _hiveService;
  List<CartModel> allCarts = [];

  CartCubit(this._cartUseCase)
    : _hiveService = GetIt.instance<HiveService>(),
      super(CartInitial()) {
    fetchCarts();
  }

  void getUserId() {}

  Future<void> fetchCarts() async {
    emit(CartLoading());

    if (!_hiveService.hasInitialized) {
      await _hiveService.init();
    }
    int userId = await _hiveService.getUserId();
    log(userId.toString());

    Either result = await _cartUseCase.getCarts();

    result.fold(
      (failure) {
        emit(CartError(failure.message));
      },
      (carts) {
        allCarts = carts;
        final userCarts = allCarts
            .where((cart) => cart.userId == userId)
            .toList();
        emit(CartLoaded(userCarts));
      },
    );
  }
}
