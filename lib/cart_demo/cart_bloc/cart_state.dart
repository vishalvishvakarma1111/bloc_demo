part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  List<CartModel>? productList;

  List<CartModel>? cartList;

  CartLoaded({this.productList, this.cartList});

  CartLoaded copyWith(List<CartModel>? productList, List<CartModel>? cartList) {
    print("--------------  ${productList}");

    return CartLoaded(
        productList: productList ?? this.productList,
        cartList: cartList ?? this.cartList);
  }
}
