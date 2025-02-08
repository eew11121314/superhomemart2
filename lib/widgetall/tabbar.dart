// widget ของหน้า main เอาไว้ใช้กับหน้าเข้าสู่ระบบแล้ว

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:superhomemart2/page1/Page1.dart';
import 'package:superhomemart2/page2/Page2.dart';
import 'package:superhomemart2/page3/Page3.dart';
import 'package:superhomemart2/page1_main/profile_m.dart';

class TabBarWidget extends StatefulWidget {
  @override
  _TabBarWidgetState createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const Page1(),
    const Page2(),
    const Page3(),
    const ProfileScreen(),
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
