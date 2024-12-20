import 'package:flutter/material.dart';
import 'package:superhomemart2/page2/jadever.dart';
import 'package:superhomemart2/page2/total.dart';
import 'package:superhomemart2/page2/ricota.dart';
import 'package:superhomemart2/page2/decakila.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Menu',
          style: TextStyle(
              fontFamily: 'Kanit'), // Apply Kanit font to AppBar title
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: const Text(
              'Jadever',
              style: TextStyle(
                  fontFamily: 'Kanit'), // Apply Kanit font to ListTile text
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const JadeverCategoryPage()),
              );
            },
          ),
          ListTile(
            title: const Text(
              'Total',
              style: TextStyle(
                  fontFamily: 'Kanit'), // Apply Kanit font to ListTile text
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TotalCategoryPage()),
              );
            },
          ),
          ListTile(
            title: const Text(
              'Ricota',
              style: TextStyle(
                  fontFamily: 'Kanit'), // Apply Kanit font to ListTile text
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RicotaCategoryPage()),
              );
            },
          ),
          ListTile(
            title: const Text(
              'Decakila',
              style: TextStyle(
                  fontFamily: 'Kanit'), // Apply Kanit font to ListTile text
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DecakilaCategoryPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
