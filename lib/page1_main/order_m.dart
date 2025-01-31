import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderPageM extends StatefulWidget {
  const OrderPageM({super.key});

  @override
  _OrderPageMState createState() => _OrderPageMState();
}

class _OrderPageMState extends State<OrderPageM> {
  String selectedAddress = "ที่อยู่ปัจจุบัน";

  void _changeAddress() {
    // ฟังก์ชันสำหรับเปลี่ยนที่อยู่
    setState(() {
      selectedAddress = "ที่อยู่ใหม่";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('ตะกร้าสินค้า', style: TextStyle(fontFamily: 'Kanit')),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/Icon/left.svg',
            width: 30,
            height: 30,
            color: Colors.white,
          ), // ใช้ SVG แทนไอคอน
          onPressed: () {
            Navigator.pop(context); // ย้อนกลับไปหน้าก่อนหน้า
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'เลือกที่อยู่จัดส่ง',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Kanit'),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha((0.5 * 255).toInt()),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedAddress,
                    style: const TextStyle(fontSize: 16, fontFamily: 'Kanit'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _changeAddress,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'เปลี่ยนที่อยู่',
                      style: TextStyle(fontFamily: 'Kanit'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'รายการสินค้าในตะกร้า',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Kanit'),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 3, // จำนวนสินค้าที่อยู่ในตะกร้า
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Image.network(
                        'http://superhomemart.duckdns.org/upload/sample_product.jpg',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: const Text(
                        'ชื่อสินค้า',
                        style: TextStyle(fontFamily: 'Kanit'),
                      ),
                      subtitle: const Text(
                        'ราคา: 100฿',
                        style: TextStyle(fontFamily: 'Kanit'),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // ฟังก์ชันสำหรับลบสินค้าออกจากตะกร้า
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // ฟังก์ชันสำหรับดำเนินการสั่งซื้อ
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'ดำเนินการสั่งซื้อ',
                  style: TextStyle(fontSize: 18, fontFamily: 'Kanit'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
