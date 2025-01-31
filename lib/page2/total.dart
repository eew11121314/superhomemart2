import 'package:flutter/material.dart';
import 'package:superhomemart2/page2/menutotal.dart';

class TotalCategoryPage extends StatelessWidget {
  const TotalCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Total',
          style: TextStyle(
            fontFamily: 'Kanit',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildCategoryTile(context, 'ปั๊มน้ำ'),
            _buildCategoryTile(context, 'เครื่องปั่นไฟ'),
            _buildCategoryTile(context, 'เครื่องมือก่อสร้าง'),
            _buildCategoryTile(context, 'เครื่องมือช่าง'),
            _buildCategoryTile(context, 'เครื่องมือลม และ อุปกรณ์'),
            _buildCategoryTile(context, 'เครื่องมือวัด'),
            _buildCategoryTile(context, 'เครื่องมือเกษตร'),
            _buildCategoryTile(context, 'เครื่องมือไฟฟ้า'),
            _buildCategoryTile(context, 'เครื่องเชื่อม และ อุปกรณ์'),
            _buildCategoryTile(context, 'เครื่องใช้ไฟฟ้า'),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTile(BuildContext context, String categoryName) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      child: ListTile(
        leading: const Icon(Icons.build, color: Colors.teal),
        title: Text(
          categoryName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Kanit', // Apply Kanit font to category names
          ),
        ),
        trailing: const Icon(Icons.arrow_forward, color: Colors.teal),
        onTap: () {
          // Handle action for selected category
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CategoryDetailPage(categoryName: categoryName)),
          );
        },
      ),
    );
  }
}
