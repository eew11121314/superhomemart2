import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData;
  bool isLoading = true;
  String? username;

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username'); // ดึง username
    debugPrint("$username");
    List<dynamic> user1 = [];
    if (username == null) {
      debugPrint("No user logged in");
      setState(() => isLoading = false);
      return;
    }

    final String url =
        "http://superhomemart.duckdns.org/api/user/member/app/user?username=$username";
    const String apiKey = "WHt)m6gpqxkF1r(oDczv8mq%";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'x-api-key': apiKey,
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          isLoading = false;
        });
        debugPrint("Success: $jsonData");
        user1 = jsonData;
        debugPrint("Success: $user1");
      } else {
        debugPrint("Failed to load profile: ${response.statusCode}");
        setState(() => isLoading = false);
      }
    } catch (e) {
      debugPrint("Error: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userData == null
              ? const Center(child: Text("Unable to connect to user profile."))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                          radius: 50,
                          backgroundImage: userData!['image'] != null
                              ? NetworkImage(userData!['image'])
                              : const AssetImage('assets/default_user.png')
                                  as ImageProvider),
                      const SizedBox(height: 10),
                      Text("${userData!['fname']} ${userData!['lname']}",
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      Text("@${userData!['username']}",
                          style: const TextStyle(
                              fontSize: 18, color: Colors.grey)),
                      const Divider(),
                      ListTile(
                          leading: const Icon(Icons.phone),
                          title: Text(userData!['number'])),
                      ListTile(
                          leading: const Icon(Icons.email),
                          title: Text(userData!['email'])),
                      ListTile(
                          leading: const Icon(Icons.home),
                          title: Text(userData!['address'])),
                    ],
                  ),
                ),
    );
  }
}
