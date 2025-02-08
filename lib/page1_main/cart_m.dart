import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartItem {
  String productName;
  String imageUrl;
  int quantity;
  double price;

  CartItem({
    required this.productName,
    required this.imageUrl,
    required this.quantity,
    required this.price,
  });
}

class CartScreen extends StatefulWidget {
  final List<CartItem> cartItems;

  const CartScreen({Key? key, required this.cartItems}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void _increaseQuantity(int index) {
    setState(() {
      widget.cartItems[index].quantity++;
    });
  }

  void _decreaseQuantity(int index) {
    setState(() {
      if (widget.cartItems[index].quantity > 1) {
        widget.cartItems[index].quantity--;
      } else {
        widget.cartItems.removeAt(index);
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      widget.cartItems.removeAt(index);
    });
  }

  double get totalPrice {
    return widget.cartItems
        .fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/Icon/left.svg',
            width: 30,
            height: 30,
            color: const Color.fromARGB(255, 18, 11, 11),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Shopping Cart'),
      ),
      body: widget.cartItems.isEmpty
          ? const Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final item = widget.cartItems[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Image.network(
                          item.imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.productName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text('Price: \$${item.price.toStringAsFixed(2)}'),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  IconButton(
                                    icon: SvgPicture.asset(
                                      'assets/Icon/minus.svg',
                                      width: 24,
                                      height: 24,
                                    ),
                                    onPressed: () => _decreaseQuantity(index),
                                  ),
                                  Text('${item.quantity}',
                                      style: const TextStyle(fontSize: 16)),
                                  IconButton(
                                    icon: SvgPicture.asset(
                                      'assets/Icon/arrow-bottom.svg',
                                      width: 24,
                                      height: 24,
                                    ),
                                    onPressed: () => _increaseQuantity(index),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    icon: SvgPicture.asset(
                                      'assets/Icon/plus.svg',
                                      width: 24,
                                      height: 24,
                                      color: Colors.red,
                                    ),
                                    onPressed: () => _removeItem(index),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: \$${totalPrice.toStringAsFixed(2)}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: widget.cartItems.isEmpty
                    ? null
                    : () {
                        // Handle checkout action
                      },
                child: const Text('Checkout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
