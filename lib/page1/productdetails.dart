// ignore_for_file: library_private_types_in_public_api, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:superhomemart2/login.dart';

class ProductDetails extends StatefulWidget {
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
  final double sh_weight;
  final double sh_length;
  final double sh_width;
  final double sh_height;

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
    required this.sh_weight, // เพิ่มข้อมูล sh_weight
    required this.sh_length, // เพิ่มข้อมูล sh_length
    required this.sh_width, // เพิ่มข้อมูล sh_width
    required this.sh_height, // เพิ่มข้อมูล sh_height
  });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool _isDetailsVisible = false; // ตัวแปรเพื่อจัดการสถานะการแสดงรายละเอียด
  bool _isSpecificationsVisible =
      false; // ตัวแปรเพื่อจัดการสถานะการแสดงขนาดสินค้า

  // ประกาศฟังก์ชัน _handleOrder
  void _handleOrder(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LoginPage()), // นำผู้ใช้ไปยังหน้า LoginPage
    );
  }

  void showExpandedImage(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Center(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit
                      .contain, // ใช้ BoxFit.contain เพื่อให้ภาพพอดีกับหน้าจอ
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Positioned(
                top: 40,
                left: 20,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pop(context); // ย้อนกลับ
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details',
            style: TextStyle(fontFamily: 'Kanit')),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    showExpandedImage(context,
                        "http://superhomemart.duckdns.org:80/upload/${widget.image}");
                  },
                  child: Image.network(
                    "http://superhomemart.duckdns.org:80/upload/${widget.image}",
                    width: double.infinity, // ทำให้กว้างเต็มที่
                    height: 400, // กำหนดความสูง
                    fit: BoxFit.cover, // ใช้ BoxFit.cover เพื่อไม่ให้ตัดขนาดรูป
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Kanit', // ใช้ฟอนต์ Kanit
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  '${widget.price} ฿',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontFamily: 'Kanit', // ใช้ฟอนต์ Kanit
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isDetailsVisible =
                          !_isDetailsVisible; // สลับสถานะการแสดงรายละเอียด
                    });
                  },
                  child: Container(
                    width: double.infinity, // ทำให้กว้างเต็มที่
                    padding: EdgeInsets.all(10),
                    color: const Color.fromARGB(255, 78, 84, 94),
                    child: const Text(
                      'รายละเอียดสินค้า',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Kanit'), // ใช้ฟอนต์ Kanit
                      textAlign: TextAlign.center, // จัดกึ่งกลางข้อความ
                    ),
                  ),
                ),

                // รายละเอียดสินค้า (ซ่อนอยู่)
                Visibility(
                  visible: _isDetailsVisible, // ใช้ตัวแปรเพื่อควบคุมการแสดง
                  child: Container(
                    width: double.infinity, // ทำให้กว้างเท่ากับปุ่ม
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2), // สีพื้นหลังที่จางๆ
                      borderRadius: BorderRadius.circular(8), // มุมโค้ง
                    ),
                    child: Text(
                      widget.description, // แสดงรายละเอียดสินค้า
                      style: TextStyle(
                          fontSize: 14, fontFamily: 'Kanit'), // เปลี่ยนฟอนต์
                    ),
                  ),
                ),

                const SizedBox(height: 16), // เพิ่มระยะห่างระหว่างปุ่ม

                // ปุ่มแสดงข้อจำเพาะ
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isSpecificationsVisible =
                          !_isSpecificationsVisible; // สลับสถานะการแสดงขนาดสินค้า
                    });
                  },
                  child: Container(
                    width: double.infinity, // ทำให้กว้างเต็มที่
                    padding: EdgeInsets.all(10),
                    color: const Color.fromARGB(255, 78, 84, 94),
                    child: const Text(
                      'ขนาดสินค้า',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Kanit'), // ใช้ฟอนต์ Kanit
                      textAlign: TextAlign.center, // จัดกึ่งกลางข้อความ
                    ),
                  ),
                ),

                // ขนาดสินค้า (ซ่อนอยู่)
                Visibility(
                  visible:
                      _isSpecificationsVisible, // ใช้ตัวแปรเพื่อควบคุมการแสดง
                  child: Container(
                    width: double.infinity, // ทำให้กว้างเท่ากับปุ่ม
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2), // สีพื้นหลังที่จางๆ
                      borderRadius: BorderRadius.circular(8), // มุมโค้ง
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'น้ำหนัก: ${widget.sh_weight} kg',
                          style: const TextStyle(
                              fontFamily: 'Kanit'), // ใช้ฟอนต์ Kanit
                        ), // แสดงน้ำหนัก
                        Text(
                          'ยาว: ${widget.sh_length} cm',
                          style: const TextStyle(
                              fontFamily: 'Kanit'), // ใช้ฟอนต์ Kanit
                        ), // แสดงความยาว
                        Text(
                          'กว้าง: ${widget.sh_width} cm',
                          style: const TextStyle(
                              fontFamily: 'Kanit'), // ใช้ฟอนต์ Kanit
                        ), // แสดงความกว้าง
                        Text(
                          'สูง: ${widget.sh_height} cm',
                          style: const TextStyle(
                              fontFamily: 'Kanit'), // ใช้ฟอนต์ Kanit
                        ), // แสดงความสูง
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),
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
                    style: TextStyle(
                        fontSize: 18, fontFamily: 'Kanit'), // ใช้ฟอนต์ Kanit
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
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // เปลี่ยนเป็น spaceBetween
          children: [
            IconButton(
              icon: const Icon(Icons.contact_support,
                  size: 30, color: Colors.blueAccent),
              onPressed: () {
                // Navigate to support page
              },
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart,
                  size: 30, color: Colors.blueAccent),
              onPressed: () {
                // Navigate to cart page
              },
            ),
            // เปลี่ยนจาก IconButton เป็น Container เพื่อเพิ่มพื้นหลังและปรับขนาด
            Container(
              width: 150, // กำหนดความกว้างของปุ่ม
              height: 50, // กำหนดความสูงของปุ่ม
              padding: const EdgeInsets.symmetric(vertical: 0), // ปรับ padding
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 35, 65, 116), // เพิ่มพื้นหลัง
                borderRadius: BorderRadius.circular(0), // ทำให้มุมไม่โค้ง
              ),
              child: TextButton(
                onPressed: () =>
                    _handleOrder(context), // เรียกใช้ฟังก์ชันเมื่อกด
                child: const Text(
                  'สั่งซื้อสินค้า',
                  style: TextStyle(
                      fontFamily: 'Kanit',
                      color:
                          Colors.white), // เปลี่ยนสีข้อความให้เข้ากับพื้นหลัง
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
