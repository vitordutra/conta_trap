import "package:flutter/material.dart";

class _CurvePainter extends CustomPainter {
  Color fillColor;

  _CurvePainter({this.fillColor = Colors.black});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..color = fillColor;

    Offset topLeft = const Offset(0, 0);
    Offset topRight = Offset(size.width, 0);
    Offset bottomLeft = Offset(0, size.height * 0.9);
    Offset bottomRight = Offset(size.width, size.height * 0.9);

    double circleRadius = size.width * 2.19;

    Path path = Path()
      ..moveTo(topLeft.dx, topLeft.dy)
      ..lineTo(bottomLeft.dx, bottomLeft.dy)
      ..arcToPoint(bottomRight,
          radius: Radius.circular(circleRadius), clockwise: false)
      ..lineTo(topRight.dx, topRight.dy)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CurvedHeader extends StatelessWidget {
  const CurvedHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    Color primaryColor = Theme.of(context).primaryColor;

    return Container(
      width: double.infinity,
      height: 0.26 * screenHeight,
      child: CustomPaint(
        painter: _CurvePainter(fillColor: primaryColor),
      ),
    );
  }
}
