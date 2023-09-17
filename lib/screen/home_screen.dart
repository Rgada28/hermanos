import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hermanos/model/product.dart';
import 'package:hermanos/provider/cart_provider.dart';
import 'package:hermanos/provider/product_list_provider.dart';
import 'package:hermanos/screen/cart_screen.dart';
import 'package:hermanos/screen/login_screen.dart';
import 'package:hermanos/utils/user_storage.dart';
import 'package:hermanos/widgets/product_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late List<Product> products;
  late List<Product> filteredProducts;

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      products =
          jsonResponse.map((product) => Product.fromMap(product)).toList();
      filteredProducts = products;
      ref.read(productListProvider.notifier).addProductList(products);
      return jsonResponse.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
                height: 150.0,
                width: 30.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (builder) {
                        return const CartScreen();
                      }),
                    );
                  },
                  child: Stack(
                    children: <Widget>[
                      const IconButton(
                        icon: Icon(
                          Icons.shopping_cart,
                          color: Colors.amber,
                        ),
                        onPressed: null,
                      ),
                      ref.read(cartProvider).products.isEmpty
                          ? Container()
                          : Positioned(
                              child: Stack(
                              children: <Widget>[
                                Icon(Icons.brightness_1,
                                    size: 20.0, color: Colors.green[800]),
                                Positioned(
                                    top: 3.0,
                                    right: 4.0,
                                    child: Center(
                                      child: Text(
                                        products.length.toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                              ],
                            )),
                    ],
                  ),
                )),
          ),
          IconButton(
              color: Colors.amber,
              onPressed: () {
                SharePreferenceHelper.setuserLoginStatus(false);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (builder) {
                  return const LoginScreen();
                }));
              },
              tooltip: "Logout",
              icon: const Icon(Icons.logout))
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Products"),
      ),
      body: FutureBuilder(
          future: fetchProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Text(
                  'Fetching Products.....',
                ),
              );
            } else if (snapshot.hasError) {
              // Handle any errors during authentication check.
              return Text('Error: ${snapshot.error}');
            }
            return ListView.builder(
                itemCount: products.length,
                itemBuilder: (builder, index) {
                  return ProductCard(product: products[index]);
                });
          }),
    );
  }
}
