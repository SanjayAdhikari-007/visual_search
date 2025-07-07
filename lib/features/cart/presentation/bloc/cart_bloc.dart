import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../products/data/models/product_model.dart';
import '../../domain/entity/cart_item.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  // Initial state of the cart
  CartCubit() : super(CartLoaded(items: {}, totalAmount: 0.0, itemCount: 0));

  // Helper to calculate total amount and item count from current items
  CartLoaded _calculateLoadedState(Map<String, CartItem> currentItems) {
    double total = 0.0;
    currentItems.forEach((key, cartItem) {
      total += cartItem.product.priceAfterDiscount * cartItem.quantity;
    });
    return CartLoaded(
      items: currentItems,
      totalAmount: total,
      itemCount: currentItems.length,
    );
  }

  void addItem(ProductModel product) {
    // Emit loading state (optional)
    // emit(CartLoading());

    print("Add: " + product.id);

    final currentItems =
        Map<String, CartItem>.from((state as CartLoaded).items);

    if (currentItems.containsKey(product.id)) {
      currentItems.update(
        product.id,
        (existingCartItem) => CartItem(
          product: existingCartItem.product,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      currentItems.putIfAbsent(
        product.id,
        () => CartItem(
          product: product,
          quantity: 1,
        ),
      );
    }
    emit(_calculateLoadedState(currentItems));
  }

  void removeItem(String productId) {
    final currentItems =
        Map<String, CartItem>.from((state as CartLoaded).items);
    currentItems.remove(productId);
    emit(_calculateLoadedState(currentItems));
  }

  void removeSingleItem(String productId) {
    final currentItems =
        Map<String, CartItem>.from((state as CartLoaded).items);
    if (!currentItems.containsKey(productId)) {
      return;
    }
    if (currentItems[productId]!.quantity > 1) {
      currentItems.update(
        productId,
        (existingCartItem) => CartItem(
          product: existingCartItem.product,
          quantity: existingCartItem.quantity - 1,
        ),
      );
    } else {
      currentItems.remove(productId);
    }
    emit(_calculateLoadedState(currentItems));
  }

  void clearCart() {
    emit(CartLoaded(items: {}, totalAmount: 0.0, itemCount: 0));
  }
}
