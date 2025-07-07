part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

class CartLoading
    extends CartState {} // Optional: For showing loading indicators

class CartLoaded extends CartState {
  final Map<String, CartItem> items;
  final double totalAmount;
  final int itemCount;

  CartLoaded({
    required this.items,
    required this.totalAmount,
    required this.itemCount,
  });

  // Allows for easy copying and modification of the state
  CartLoaded copyWith({
    Map<String, CartItem>? items,
    double? totalAmount,
    int? itemCount,
  }) {
    return CartLoaded(
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      itemCount: itemCount ?? this.itemCount,
    );
  }
}

class CartError extends CartState {
  final String message;
  CartError(this.message);
}
