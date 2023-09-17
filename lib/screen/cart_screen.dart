import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/cart_product_list.dart';
import '../widgets/cart_summary.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Column(
        children: [
          // 80% of the screen for product list
          Expanded(
            flex: 9,
            child: CartProductList(),
          ),
          // 20% of the screen for cart summary
          Expanded(
            flex: 1,
            child: CartSummary(),
          ),
        ],
      ),
    );
  }
}
