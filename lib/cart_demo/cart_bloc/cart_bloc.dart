import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../cart_model.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartEvent>((event, emit) async {
      emit(CartLoaded());
    });

    on<CartLoadedEvent>((event, emit) {
      CartLoaded cartLoaded = state as CartLoaded;
      cartLoaded.productList = [];
      cartLoaded.cartList = [];
      for (int i = 0; i < 10; i++) {
        cartLoaded.productList
            ?.add(CartModel(title: "Product $i", isAdded: false));
      }
      emit(cartLoaded.copyWith(cartLoaded.productList, cartLoaded.cartList));
    });

    on<AddToCartEvent>(_addToCart);
  }

  FutureOr<void> _addToCart(AddToCartEvent event, Emitter<CartState> emit) {
    CartLoaded lastState = state as CartLoaded;
    lastState.cartList?.add(CartModel(title: "Product 0", isAdded: true));
    emit(lastState.copyWith(
        lastState.productList ?? [], lastState.cartList ?? []));
  }
}
