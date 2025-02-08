import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:superhomemart2/page4/editprofile_2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  File? _profileImage;
  String? _username; // เก็บชื่อผู้ใช้จาก API

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
    fetchUsers(); // ดึงข้อมูลผู้ใช้จาก API เมื่อเปิดหน้า
  }

  Future<void> fetchUsers() async {
    const String url =
        "http://superhomemart.duckdns.org:80/api/user/member/app";
    const String apiKey = "WHt)m6gpqxkF1r(oDczv8mq%";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $apiKey", // ถ้าต้องการ Auth
          "Content-Type": "application/json"
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // สมมติว่า API ส่งคืนข้อมูลแบบนี้
        // {"username": "JohnDoe", "email": "john@example.com"}
        setState(() {
          _username = data['username'];
          _usernameController.text = _username ?? "";
        });
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching users: $e");
    }
  }

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('profile_image_path');
    if (imagePath != null) {
      setState(() {
        _profileImage = File(imagePath);
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _profileImage = File(pickedImage.path);
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image_path', pickedImage.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          title: const Text(
            'Edit Profile',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Kanit',
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!)
                    : const AssetImage('assets/1.jpg') as ImageProvider,
                child: _profileImage == null
                    ? SvgPicture.asset(
                        'assets/Icon/add-camera.svg',
                        width: 20,
                        height: 20,
                        color: Colors.white,
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 14),
            _buildTextField(_usernameController, 'Username', false),
            const SizedBox(height: 14),
            _buildPasswordField(_passwordController, 'New password'),
            const SizedBox(height: 24),
            _buildGradientButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, bool obscure) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(fontFamily: 'Kanit'),
          ),
          obscureText: obscure,
          style: const TextStyle(fontFamily: 'Kanit'),
        ),
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String label) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(fontFamily: 'Kanit'),
            suffixIcon: IconButton(
              icon: SvgPicture.asset(
                _obscurePassword
                    ? 'assets/Icon/eyeoff.svg'
                    : 'assets/Icon/eyeon.svg',
                width: 20,
                height: 20,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
          obscureText: _obscurePassword,
          style: const TextStyle(fontFamily: 'Kanit'),
        ),
      ),
    );
  }

  Widget _buildGradientButton() {
    return GestureDetector(
      onTap: () {
        String newPassword = _passwordController.text;
        String username = _usernameController.text;

        if (username.isEmpty || newPassword.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'กรุณาใส่ข้อมูลให้ครบถ้วน',
                style: TextStyle(fontFamily: 'Kanit'),
              ),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        if (username != "JohnDoe" || newPassword != "123456") {
          // ตรงนี้ต้องเปลี่ยนให้เช็คจากฐานข้อมูลจริง
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'username หรือ password อาจไม่ถูกต้อง',
                style: TextStyle(fontFamily: 'Kanit'),
              ),
              backgroundColor: Colors.orange,
            ),
          );
          return;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'เข้าสู่ระบบสำเร็จ!',
              style: TextStyle(fontFamily: 'Kanit'),
            ),
            backgroundColor: Colors.green,
          ),
        );

        Future.delayed(const Duration(seconds: 1), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EditProfilePage2(),
            ),
          );
        });
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF073074), Color(0xFF1a6f96)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        alignment: Alignment.center,
        child: const Text(
          'เข้าสู่ระบบ',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Kanit',
          ),
        ),
      ),
    );
  }
}
