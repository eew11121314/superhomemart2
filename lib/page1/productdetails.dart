import 'package:flutter/material.dart';
import 'package:superhomemart2/login.dart';

class ProductDetails extends StatelessWidget {
  final String name;
  final String image;
  final double price;
  final String sku;
  final String description; // เพิ่มพารามิเตอร์ description
  final String category; // เพิ่มพารามิเตอร์ category
  final int stock; // เพิ่มพารามิเตอร์ stock
  final String photo_1;
  final String photo_2;
  final String photo_3;
  final String photo_4;
  final String photo_5;
  final String photo_6;

  const ProductDetails({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.sku,
    required this.description, // เพิ่มพารามิเตอร์ description
    required this.category, // เพิ่มพารามิเตอร์ category
    required this.stock, // เพิ่มพารามิเตอร์ stock
    required this.photo_1,
    required this.photo_2,
    required this.photo_3,
    required this.photo_4,
    required this.photo_5,
    required this.photo_6,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            // ใช้ Center widget เพื่อจัดให้อยู่กลาง
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // จัดแนวกลางในแนวตั้ง
              children: [
                // Display product image
                Image.network(
                  "http://superhomemart.duckdns.org:80/upload/$image",
                  height: 300,
                  fit:
                      BoxFit.contain, // ใช้ BoxFit.contain เพื่อให้รูปไม่เบี้ยว
                ),
                const SizedBox(height: 16),

                // Display product name
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                // Display price
                Text(
                  '$price฿', // แสดงราคาโดยไม่ใช้ $ และใช้เฉพาะ ฿
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 16),

                // Display product description
                Text(
                  description, // แสดงรายละเอียดสินค้า
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 16),

                // Display SKU (ซ่อนหรือแสดงตามต้องการ)
                // Text(
                //   'SKU: $sku',
                //   style: const TextStyle(fontSize: 16),
                // ),
                const SizedBox(height: 32),

                // Add to Cart button
                ElevatedButton(
                  onPressed: () {
                    // Add product to cart functionality
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 206, 211, 218),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.contact_support,
                  size: 30, color: Colors.blueAccent),
              onPressed: () {
                debugPrint('Contact Admin');
              },
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart,
                  size: 30, color: Colors.blueAccent),
              onPressed: () {
                debugPrint('View Cart');
              },
            ),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0567FF), Color(0xFF0567FF)],
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              child: IconButton(
                icon: const Icon(Icons.shopping_basket,
                    size: 30, color: Colors.white),
                onPressed: () {
                  // นำทางไปยังหน้า LoginPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            LoginPage()), // นำทางไปยัง LoginPage
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Dummy function for _handleOrder. You can implement actual functionality.
  void _handleOrder(BuildContext context) {
    debugPrint('Handling order...');
    // You can navigate to the checkout page or any other action you need here.
  }
}
