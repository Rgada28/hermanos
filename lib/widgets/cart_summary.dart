import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hermanos/provider/cart_provider.dart';

class CartSummary extends ConsumerStatefulWidget {
  const CartSummary({super.key});

  @override
  ConsumerState<CartSummary> createState() => _CartSummaryState();
}

class _CartSummaryState extends ConsumerState<CartSummary> {
  @override
  Widget build(BuildContext context) {
    double cartValue = ref.read(cartProvider).value;

    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              'Cart Value: \$${cartValue.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {},
                child: const Text(
                  "Checkout",
                  style: TextStyle(fontSize: 20),
                )),
          )
        ],
      ),
    );
  }
}
