import 'package:premium_filter/export.dart';

class BackBtn extends StatelessWidget {
  BackBtn({super.key, this.onTap});

  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap != null ? onTap!() : Get.back(),
      child: ClipPath(
        clipper: ArrowClipper(),
        child: Container(
          width: 110,
          height: 35,
          color: Colors.red,
          child: Stack(
            children: [
              Positioned(
                right: 8,
                top: 2,
                child: Center(
                  child: Text(
                    'return'.tr,
                    style: oswaldBlack.copyWith(
                        color: Colors.white,
                        fontSize: Dimensions.fontSizeExtraLarge),
                  ),
                ),
              ),
              Positioned(
                left: 15,
                top: 13,
                child: CustomPaint(
                  size: const Size(8, 8), // You can change this as needed
                  painter: TrianglePainter(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    final paint = Paint()..color = Colors.white;
    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.width);
    path.lineTo(size.height, size.width);
    path.close();
    // Translate to the center of the triangle
    canvas.translate(size.width / 2, size.width / 2);
    // Rotate the canvas
    canvas.rotate(11);
    // Translate back to the top-left corner of the triangle
    canvas.translate(-size.width / 2, -size.width / 2);

    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.height / 2, size.height);
    path.lineTo(0, size.height / 2);
    path.lineTo(size.height / 2, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
