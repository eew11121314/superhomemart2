import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpcenterPage extends StatefulWidget {
  const HelpcenterPage({super.key});

  @override
  _HelpcenterPageState createState() => _HelpcenterPageState();
}

class _HelpcenterPageState extends State<HelpcenterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildInfoCard(
                context,
                icon: Icons.call,
                title: 'Call us:',
                content:
                    'Phone: 098 827 6425\nเวลาทำการ: วันจันทร์-เสาร์ 08:30 น. – 17:30 น.',
                titleStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Kanit'),
                contentStyle:
                    const TextStyle(fontSize: 12, fontFamily: 'Kanit'),
              ),
              const SizedBox(height: 20),
              _buildInfoCard(
                context,
                icon: Icons.mark_as_unread_sharp,
                title: 'Chat with Us:',
                content:
                    'Line: @Superhomemart\nLive Chat Operating hours: วันจันทร์-เสาร์ 08:30 น. – 17:30 น.\nAddress: 654/23 ถนนพระรามที่ 4 แขวงมหาพฤฒาราม เขตบางรัก กรุงเทพมหานคร 10500',
                titleStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Kanit'),
                contentStyle:
                    const TextStyle(fontSize: 12, fontFamily: 'Kanit'),
              ),
              const SizedBox(height: 30),
              Center(
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: Image.asset(
                    'assets/Map-01-01.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF073074), // Start color
                        Color(0xFF1a6f96), // End color
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(0, 4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () async {
                      const url =
                          'https://www.google.com/maps?ll=13.72952,100.523046&z=16&t=h&hl=en-US&gl=US&mapclient=embed&cid=6624635690869510169';
                      final Uri uri = Uri.parse(url);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                      child: Text(
                        'Google Map',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Kanit',
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Container(
          decoration: const BoxDecoration(),
          child: AppBar(
            title: const Text(
              'Help Us',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Kanit',
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String content,
    TextStyle? titleStyle,
    TextStyle? contentStyle,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 28, color: const Color(0xFF0F44A9)),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: titleStyle ??
                      const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Kanit'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: contentStyle ??
                  const TextStyle(fontSize: 16, fontFamily: 'Kanit'),
            ),
          ],
        ),
      ),
    );
  }
}
