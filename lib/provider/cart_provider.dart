import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hermanos/model/cart.dart';

import '../model/product.dart';

final cartProvider = StateNotifierProvider<CartNotifier, Cart>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<Cart> {
  CartNotifier()
      : super(Cart(
            cartId: "1",
            userId: "1",
            date: DateTime.now(),
            products: [],
            value: 0));

  void addToCart(Product product, int quantity) {
    if (state.products.indexWhere((cp) => product.id == cp.product.id) > 0) {
    } else {
      state.products = [
        ...state.products,
        CartProduct(product: product, quantity: quantity)
      ];
    }
  }

  void removeFromCart(Product product) {
    final updatedCart = state;
    final index = state.products
        .indexWhere((element) => element.product.id == product.id);
    if (index > 0) {
      updatedCart.products[index].quantity--;
    }
    state = updatedCart;
  }
}
