import 'package:flutter/material.dart';
import 'package:superhomemart2/page1/Page1.dart';
import 'package:superhomemart2/page2/Page2.dart';
import 'package:superhomemart2/page3/Page3.dart';
import 'package:superhomemart2/Login.dart';
import 'package:superhomemart2/page1/delivery.dart';
import 'package:superhomemart2/page4/editprofile.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  await windowManager.setSize(const Size(428, 926));
  await windowManager.setMinimumSize(const Size(428, 926));
  await windowManager.setMaximumSize(const Size(428, 926));

  await windowManager.setResizable(false);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      routes: {
        '/login': (context) => LoginPage(),
        '/delivery': (context) => const DeliveryPage(productName: '',),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;


  final List<Widget> _pages = [
    const Page1(),
    const Page2(),
    const Page3(),
    const EditProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedLabelStyle: const TextStyle(fontFamily: 'Kanit'),
        unselectedLabelStyle: const TextStyle(fontFamily: 'Kanit'), 
      ),
    );
  }
}
