import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        '/login': (context) => const LoginPage(),
        '/delivery': (context) => const DeliveryPage(
              productName: '',
            ),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
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
        items: [
          BottomNavigationBarItem(
            icon:
                SvgPicture.asset('assets/Icon/home.svg', width: 24, height: 24),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon:
                SvgPicture.asset('assets/Icon/menu.svg', width: 24, height: 24),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/Icon/settings.svg',
                width: 24, height: 24),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon:
                SvgPicture.asset('assets/Icon/user.svg', width: 24, height: 24),
            label: 'Profile',
          ),
        ],
        selectedLabelStyle: const TextStyle(fontFamily: 'Kanit'),
        unselectedLabelStyle: const TextStyle(fontFamily: 'Kanit'),
      ),
    );
  }
}
