import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart'; // นำเข้า package สำหรับใช้ TextInputFormatter

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController(); // ยืนยันรหัสผ่าน
  final TextEditingController _firstNameController =
      TextEditingController(); // ชื่อจริง
  final TextEditingController _lastNameController =
      TextEditingController(); // นามสกุล
  final TextEditingController _phoneController =
      TextEditingController(); // เบอร์โทร
  final TextEditingController _addressController =
      TextEditingController(); // ที่อยู่

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // ตัวแปรสำหรับตรวจสอบกรอบที่ผิด
  bool _isUsernameValid = true;
  bool _isEmailValid = true;
  bool _isPasswordValid = true;
  bool _isConfirmPasswordValid = true;
  bool _isFirstNameValid = true;
  bool _isLastNameValid = true;
  bool _isPhoneValid = true;
  bool _isAddressValid = true;

  // ฟังก์ชันแสดง alert message
  void _showAlert(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 50,
          ),
          content: Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(fontFamily: 'Kanit'),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(fontFamily: 'Kanit'),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // ฟังก์ชันเชื่อมต่อ API
  Future<void> _registerUser() async {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String phone = _phoneController.text;
    String address = _addressController.text;

    // ตรวจสอบข้อมูลที่กรอกในแต่ละช่อง
    setState(() {
      _isUsernameValid = username.isNotEmpty;
      _isEmailValid = email.isNotEmpty;
      _isPasswordValid = password.isNotEmpty;
      _isConfirmPasswordValid = confirmPassword.isNotEmpty;
      _isFirstNameValid = firstName.isNotEmpty;
      _isLastNameValid = lastName.isNotEmpty;
      _isPhoneValid = phone.isNotEmpty && phone.length == 10;
      _isAddressValid = address.isNotEmpty;
    });

    // เช็คข้อมูลที่จำเป็นก่อนส่งไปยัง API
    if (!(_isUsernameValid &&
        _isEmailValid &&
        _isPasswordValid &&
        _isConfirmPasswordValid &&
        _isFirstNameValid &&
        _isLastNameValid &&
        _isPhoneValid &&
        _isAddressValid)) {
      _showAlert(context, 'Please fill in all fields correctly');
      return;
    }

    if (password != confirmPassword) {
      _showAlert(context, 'Passwords do not match');
      return;
    }

    // ส่งข้อมูลไปยัง API
    try {
      var url = Uri.parse(
          'http://superhomemart.duckdns.org:3333/api/upload/user/member/app');
      var response = await http.post(url, body: {
        'fname': firstName,
        'lname': lastName,
        'number': phone,
        'email': email,
        'username': username,
        'password': password,
        'address': address,
        'membership_levels': 'member',
      });

      if (response.statusCode == 201) {
        var data = jsonDecode(response.body);
        if (data['message'] != null) {
          // ทำสิ่งที่ต้องการเมื่อสมัครสมาชิกสำเร็จ
          _showAlert(context, 'Registration successful: ${data['message']}');
          Navigator.pushNamed(context, '/login') as bool?;
        } else {
          _showAlert(context, 'Unexpected success response');
        }
      } else {
        _showAlert(context, 'ลงทะเบียนไม่สำเร็จ');
      }
    } catch (e) {
      _showAlert(context, 'An error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('', style: TextStyle(fontFamily: 'Kanit')),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF072E6F), Color(0xFF0C437D)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF073074), Color(0xFF1a6f96)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Kanit',
                    ),
                  ),
                  const SizedBox(height: 20),
                  // ชื่อจริง
                  TextField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      hintText: 'First Name',
                      hintStyle: const TextStyle(fontFamily: 'Kanit'),
                      prefixIcon: const Icon(Icons.person, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      filled: true,
                      fillColor: _isFirstNameValid
                          ? Colors.white.withOpacity(0.8)
                          : Colors.red.withOpacity(0.3),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // นามสกุล
                  TextField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      hintText: 'Last Name',
                      hintStyle: const TextStyle(fontFamily: 'Kanit'),
                      prefixIcon: const Icon(Icons.person, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      filled: true,
                      fillColor: _isLastNameValid
                          ? Colors.white.withOpacity(0.8)
                          : Colors.red.withOpacity(0.3),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // เบอร์โทร (ใส่เฉพาะตัวเลขและจำกัด 10 ตัว)
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly, // แค่ตัวเลข
                      LengthLimitingTextInputFormatter(10), // จำกัด 10 ตัว
                    ],
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      hintStyle: const TextStyle(fontFamily: 'Kanit'),
                      prefixIcon: const Icon(Icons.phone, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      filled: true,
                      fillColor: _isPhoneValid
                          ? Colors.white.withOpacity(0.8)
                          : Colors.red.withOpacity(0.3),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // ชื่อผู้ใช้
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      hintStyle: const TextStyle(fontFamily: 'Kanit'),
                      prefixIcon:
                          const Icon(Icons.account_circle, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      filled: true,
                      fillColor: _isUsernameValid
                          ? Colors.white.withOpacity(0.8)
                          : Colors.red.withOpacity(0.3),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // อีเมล
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: const TextStyle(fontFamily: 'Kanit'),
                      prefixIcon: const Icon(Icons.email, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      filled: true,
                      fillColor: _isEmailValid
                          ? Colors.white.withOpacity(0.8)
                          : Colors.red.withOpacity(0.3),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // รหัสผ่าน
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: const TextStyle(fontFamily: 'Kanit'),
                      prefixIcon: const Icon(Icons.lock, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      filled: true,
                      fillColor: _isPasswordValid
                          ? Colors.white.withOpacity(0.8)
                          : Colors.red.withOpacity(0.3),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // ยืนยันรหัสผ่าน
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      hintStyle: const TextStyle(fontFamily: 'Kanit'),
                      prefixIcon: const Icon(Icons.lock, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      filled: true,
                      fillColor: _isConfirmPasswordValid
                          ? Colors.white.withOpacity(0.8)
                          : Colors.red.withOpacity(0.3),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // ที่อยู่
                  TextField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      hintText: 'Address',
                      hintStyle: const TextStyle(fontFamily: 'Kanit'),
                      prefixIcon:
                          const Icon(Icons.location_on, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      filled: true,
                      fillColor: _isAddressValid
                          ? Colors.white.withOpacity(0.8)
                          : Colors.red.withOpacity(0.3),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF063A70),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 16),
                    ),
                    onPressed: _registerUser,
                    child: const Text(
                      'Register',
                      style: TextStyle(
                          fontFamily: 'Kanit',
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
