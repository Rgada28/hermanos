import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hermanos/model/cart.dart';
import 'package:hermanos/provider/cart_provider.dart';

class CartProductList extends ConsumerWidget {
  const CartProductList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Replace this with your actual product list
    late List<CartProduct> products = ref.read(cartProvider).products;

    return ListView.builder(
      itemCount: ref.read(cartProvider).products.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(products[index].product.title),
          // Add more product details here
        );
      },
    );
  }
}
