import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart'; // เพิ่มการนำเข้า
import 'package:shared_preferences/shared_preferences.dart'; // เพิ่มการนำเข้า

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _usernameController =
      TextEditingController(); // เพิ่ม TextEditingController สำหรับ username
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true; // เพิ่มตัวแปรเพื่อควบคุมการมองรหัสผ่าน
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
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
            _buildTextField(_usernameController, 'Username',
                false), // เพิ่มช่องใส่ username
            const SizedBox(height: 14),
            _buildPasswordField(_passwordController,
                'New password'), // เพิ่มช่องใส่ password พร้อมฟีเจอร์เปิดปิดการมองรหัสผ่าน
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
            labelStyle: const TextStyle(
              fontFamily: 'Kanit',
            ),
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
            labelStyle: const TextStyle(
              fontFamily: 'Kanit',
            ),
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

        if (newPassword.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Profile updated!',
                style: TextStyle(fontFamily: 'Kanit'),
              ),
            ),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Please fill in all fields',
                style: TextStyle(fontFamily: 'Kanit'),
              ),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF073074), // Start color
              Color(0xFF1a6f96), // End color
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        alignment: Alignment.center,
        child: const Text(
          'Save Changes',
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
