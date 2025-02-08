import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DraggableCartIcon extends StatefulWidget {
  const DraggableCartIcon({super.key});

  @override
  _DraggableCartIconState createState() => _DraggableCartIconState();
}

class _DraggableCartIconState extends State<DraggableCartIcon> {
  double posX = 350; // ตำแหน่งเริ่มต้น X
  double posY = 770; // ตำแหน่งเริ่มต้น Y

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: posY,
      left: posX,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            posX += details.delta.dx;
            posY += details.delta.dy;
          });
        },
        child: SvgPicture.asset(
          'assets/Icon/cart.svg', // ไฟล์ SVG ของไอคอนรถเข็น
          width: 40,
          height: 40,
        ),
      ),
    );
  }
}
