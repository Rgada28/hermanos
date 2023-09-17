import 'package:hermanos/model/product.dart';

class Cart {
  String cartId;
  String userId;
  DateTime date;
  List<CartProduct> products;
  double value;
  Cart(
      {required this.cartId,
      required this.userId,
      required this.date,
      required this.products,
      required this.value});

  factory Cart.fromMap(Map<String, dynamic> map) {
    // final List<dynamic> productMaps = map['products'];
    // final List<Product> cartProducts = productMaps
    //     .map((productMap) => Product.fromMap(productMap))
    //     .toList();

    return Cart(
        cartId: map['id'],
        userId: map['userId'],
        date: DateTime.parse(map['date']),
        products: [],
        value: 0);
  }

  Map<String, dynamic> toMap() {
    final List<Map<String, dynamic>> productMaps =
        products.map((product) => product.toMap()).toList();

    return {
      'id': cartId,
      'userId': userId,
      'date': date.toIso8601String(),
      'products': productMaps,
    };
  }
}

class CartProduct {
  Product product;
  int quantity;
  CartProduct({required this.product, required this.quantity});

  factory CartProduct.fromMap(Map<String, dynamic> map) {
    return CartProduct(
      product: map['product'],
      quantity: map['quantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product': product,
      'quantity': quantity,
    };
  }
}
