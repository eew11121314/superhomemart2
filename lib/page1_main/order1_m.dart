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
    setState(() {
      selectedAddress = "ที่อยู่ใหม่";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ตะกร้าสินค้า',
          style: TextStyle(fontFamily: 'Kanit', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/Icon/left.svg',
            width: 30,
            height: 30,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('เลือกที่อยู่จัดส่ง'),
            _buildAddressCard(),
            const SizedBox(height: 20),
            _buildSectionTitle('รายการสินค้าในตะกร้า'),
            const SizedBox(height: 10),
            Expanded(child: _buildCartList()),
            const SizedBox(height: 20),
            _buildCheckoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'Kanit',
      ),
    );
  }

  Widget _buildAddressCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
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
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _changeAddress,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('เปลี่ยนที่อยู่',
                  style: TextStyle(fontFamily: 'Kanit')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartList() {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 3,
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'http://superhomemart.duckdns.org/upload/sample_product.jpg',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            title: const Text(
              'ชื่อสินค้า',
              style:
                  TextStyle(fontFamily: 'Kanit', fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'ราคา: 100฿',
              style: TextStyle(fontFamily: 'Kanit', color: Colors.grey),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {},
            ),
          ),
        );
      },
    );
  }

  Widget _buildCheckoutButton() {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          child: const Text(
            'ดำเนินการสั่งซื้อ',
            style: TextStyle(
                fontSize: 18, fontFamily: 'Kanit', fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
