import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    //https://api.flutter.dev/flutter/dart-async/Timer/Timer.periodic.html
    Timer.periodic(Duration(milliseconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: Transform.rotate(
        angle: -pi/2,
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  var curr = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width/2;
    var centerY = size.height/2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var fillBrush = Paint()
      ..color = Color(0xFF446BAD);

    var outlineBrush = Paint()
      ..color = Color(0xFFA2B5D6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    var centerFillBrush = Paint()
      ..color = Color(0xFFEAECFF);

    var hourHandBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFFA0AD44), Color(0x22A0AD44)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 7.5;

    var minHandBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFFAD5244), Color(0x22AD5244)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;

    var secHandBrush = Paint()
      ..color = Colors.orange[300]
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;
      
    var dashBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.5;

    var dashBrushMinor = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    canvas.drawCircle(center, radius - 20, fillBrush);
    canvas.drawCircle(center, radius - 20, outlineBrush);
    //for exact position of hour hand according to how much of hour has passed
    var hourHandX = centerX +
        50 * cos((curr.hour * 30 + curr.minute * 0.5 + curr.second * 0.00833) * pi / 180);
    var hourHandY = centerX +
        50 * sin((curr.hour * 30 + curr.minute * 0.5 + curr.second * 0.00833) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    var minHandX = centerX +
        80 * cos((curr.minute * 6 + curr.second * 0.1) * pi / 180);
    var minHandY = centerX +
        80 * sin((curr.minute * 6 + curr.second * 0.1) * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);
    
    var secHandX = centerX +
        80 * cos((curr.second * 6 + curr.millisecond * 0.006) * pi / 180);
    var secHandY = centerX +
        80 * sin((curr.second * 6 + curr.millisecond * 0.006) * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    canvas.drawCircle(center, 10, centerFillBrush);

    var outerCircleRadius = radius - 30;
    var innerCircleRadius = radius - 40;
    var outerCircleRadiusMinor = radius - 30;
    var innerCircleRadiusMinor = radius - 40;
    
    for (double i = 0; i < 360; i += 30) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerY + outerCircleRadius * sin(i * pi / 180);
      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerY + innerCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }

    for (double i = 0; i < 360; i += 6) {
      var x3 = centerX + outerCircleRadiusMinor * cos(i * pi / 180);
      var y3 = centerY + outerCircleRadiusMinor * sin(i * pi / 180);
      var x4 = centerX + innerCircleRadiusMinor * cos(i * pi / 180);
      var y4 = centerY + innerCircleRadiusMinor * sin(i * pi / 180);
      canvas.drawLine(Offset(x3, y3), Offset(x4, y4), dashBrushMinor);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
