part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartLoadedEvent extends CartEvent {}

class AddToCartEvent extends CartEvent {}
