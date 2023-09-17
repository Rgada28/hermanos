import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartButton extends ConsumerStatefulWidget {
  CartButton(
      {super.key,
      required this.addToCard,
      required this.removeFromCard,
      required this.quantity});

  int quantity;
  final Function addToCard;
  final Function removeFromCard;

  @override
  ConsumerState<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends ConsumerState<CartButton> {
  late int quantity;
  @override
  void initState() {
    super.initState();
    quantity = widget.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        shadowColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: Colors.white)),
        child: SizedBox(
          height: 50,
          width: 150,
          child: quantity == 0
              ? TextButton(
                  child: const Text(
                    'Add Item',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    widget.addToCard();

                    setState(() {
                      quantity++;
                    });
                  },
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          quantity--;
                        });
                      },
                    ),
                    Text(quantity.toString()),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        widget.removeFromCard();
                        setState(() {
                          quantity++;
                        });
                      },
                    ),
                  ],
                ),
        ));
  }
}
