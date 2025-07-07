part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class AddToCartEvent extends CartEvent {
  final ProductModel product;
  AddToCartEvent(this.product);
}

class RemoveFromCartEvent extends CartEvent {
  final String productId;
  RemoveFromCartEvent(this.productId);
}

class RemoveSingleItemEvent extends CartEvent {
  final String productId;
  RemoveSingleItemEvent(this.productId);
}

class ClearCartEvent extends CartEvent {}
