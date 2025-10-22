import 'package:flutter/material.dart';
import 'package:gamepads/gamepads.dart';

void main() {
  runApp(const MyGamepadApp());
}

class MyGamepadApp extends StatefulWidget {
  const MyGamepadApp({super.key});

  @override
  State<MyGamepadApp> createState() => _MyGamepadAppState();
}

class _MyGamepadAppState extends State<MyGamepadApp> {
  Offset position = const Offset(100, 100);

  @override
  void initState() {
    super.initState();
    // Usa il nuovo stream dalla versione 0.1.5+
    Gamepads.events.listen((event) {
      if (event.key.startsWith('axis_')) {
        // Axis events: gestisci i movimenti degli stick
        double value = event.value;
        if (event.key == 'axis_left_x') {
          setState(() {
            position = Offset(position.dx + value * 5, position.dy);
          });
        }
        if (event.key == 'axis_left_y') {
          setState(() {
            position = Offset(position.dx, position.dy + value * 5);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: CustomPaint(
          painter: SquarePainter(position),
          child: Container(),
        ),
      ),
    );
  }
}

class SquarePainter extends CustomPainter {
  final Offset position;
  SquarePainter(this.position);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.blueAccent;
    canvas.drawRect(
      Rect.fromLTWH(position.dx, position.dy, 50, 50),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant SquarePainter oldDelegate) {
    return oldDelegate.position != position;
  }
}
