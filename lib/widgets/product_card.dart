import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hermanos/model/product.dart';
import 'package:hermanos/provider/cart_provider.dart';

import 'cart_button.dart';

class ProductCard extends ConsumerWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int quantity = 0;
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(
            product.image,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  RatingBarIndicator(
                    rating: product.rating.rate,
                    itemCount: 5,
                    itemSize: 20,
                    itemBuilder: (context, index) {
                      return const Icon(
                        Icons.star,
                        color: Colors.amber,
                      );
                    },
                  ),
                  Text('(${product.rating.count})')
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.description,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                  child: CartButton(
                quantity: quantity,
                addToCard: () {
                  ref.read(cartProvider.notifier).addToCart(product, quantity);
                },
                removeFromCard: () {
                  ref.read(cartProvider.notifier).removeFromCart(product);
                },
              ))),
        ],
      ),
    );
  }
}
