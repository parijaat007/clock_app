import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  final double size;

  const ClockView({Key key, this.size}) : super(key: key);
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
      width: widget.size,
      height: widget.size,
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

    var fillBrush = Paint()..color = Color(0xFF446BAD);

    var outlineBrush = Paint()
      ..color = Color(0xFFA2B5D6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width/30;

    var centerFillBrush = Paint()..color = Color(0xFFEAECFF);

    var hourHandBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFFA0AD44), Color(0x22A0AD44)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width/40;

    var minHandBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFFAD5244), Color(0x22AD5244)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width/75;

    var secHandBrush = Paint()
      ..color = Colors.orange[300]
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width/200;

    var dashBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width/100;

    var dashBrushMinor = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width/250;

    canvas.drawCircle(center, radius*0.90, fillBrush);
    canvas.drawCircle(center, radius*0.90, outlineBrush);
    //for exact position of hour hand according to how much of hour has passed
    var hourHandX = centerX +
            radius*0.35 * cos((curr.hour*30 + curr.minute*0.5 + curr.second*0.00833) * pi/180);
    var hourHandY = centerX +
            radius*0.35 * sin((curr.hour*30 + curr.minute*0.5 + curr.second*0.00833) * pi/180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    var minHandX =
        centerX + radius*0.60 * cos((curr.minute * 6 + curr.second * 0.1) * pi / 180);
    var minHandY =
        centerX + radius*0.60 * sin((curr.minute * 6 + curr.second * 0.1) * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    var secHandX = centerX +
        radius*0.75 * cos((curr.second * 6 + curr.millisecond * 0.006) * pi / 180);
    var secHandY = centerX +
        radius*0.75 * sin((curr.second * 6 + curr.millisecond * 0.006) * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    canvas.drawCircle(center, radius*0.05, centerFillBrush);

    var outerCircleRadius = radius*0.8;
    var innerCircleRadius = radius*0.75;
    var outerCircleRadiusMinor = radius*0.8;
    var innerCircleRadiusMinor = radius*0.75;

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
