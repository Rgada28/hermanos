import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/product.dart';

final productListProvider =
    StateNotifierProvider<ProductListNotifier, List<Product>>((ref) {
  return ProductListNotifier();
});

class ProductListNotifier extends StateNotifier<List<Product>> {
  ProductListNotifier() : super([]);

  void addProductList(List<Product> products) {
    state = [...products];
  }
}
