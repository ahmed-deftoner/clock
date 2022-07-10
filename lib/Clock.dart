import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';

class Clock extends StatefulWidget {

  final double size;

  const Clock({Key key, this.size}) : super(key: key);

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {

      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size,
      width: widget.size,
      child: Transform.rotate(
        angle: -pi/2,
        child: CustomPaint(
           painter: ClockPainter(),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter{

  var dateTime=DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.height / 2;
    var centerY = size.width / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var fillbrush = Paint()
      ..color = Color(0xFF444974);

    var outlinebrush = Paint()
      ..color = Color(0xFFFFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width/20;

    var centerbrush = Paint()
      ..color = Color(0xFFFFFFFF);

    var secbrush = Paint()
      ..color = Colors.orange[300]
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width/50;


    var dashBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    var minbrush = Paint()
      ..shader = RadialGradient(colors: [Colors.blue, Colors.blue[900]]).
      createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width/30;

    var hourbrush = Paint()
      ..shader = RadialGradient(colors: [Colors.pink, Colors.pink[900]]).
      createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width/24;

    canvas.drawCircle(center, radius *0.75, fillbrush);
    canvas.drawCircle(center, radius *0.75, outlinebrush);
    canvas.drawCircle(center, radius*0.12, centerbrush);

    var hX = centerX +
        radius*0.4* cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hY = centerX +
        radius*0.4 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hX, hY), hourbrush);

    var minX = centerX + radius*0.6 * cos(dateTime.minute * 6 * pi / 180);
    var minY = centerX + radius*0.6 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minX, minY), minbrush);

    var secondX = centerX + radius*0.7 * cos(dateTime.second * 6 * pi / 180);
    var secondY = centerX + radius*0.7 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secondX, secondY), secbrush);

    var outerCircleRadius = radius;
    var innerCircleRadius = radius *0.9;
    for (double i = 0; i < 360; i += 12) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerX + outerCircleRadius * sin(i * pi / 180);
      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerX + innerCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
   return true;
  }

}