import 'package:premium_filter/export.dart';

class DashboardBtnWidget extends StatefulWidget {
  const DashboardBtnWidget({super.key, required this.image, required this.text, required this.onPress});

  final String image;
  final String text;
  final VoidCallback onPress;

  @override
  State<DashboardBtnWidget> createState() => _DashboardBtnWidgetState();
}

class _DashboardBtnWidgetState extends State<DashboardBtnWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onPress(),
      child: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: colorPrimary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: AlignmentGeometry.lerp(Alignment.centerLeft, Alignment.center, 0.02)!,
              child: CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: SvgPicture.asset(
                      widget.image,
                      width: 45,
                      height: 45,
                      colorFilter: const ColorFilter.mode(colorPrimary, BlendMode.srcIn),
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FractionallySizedBox(
                widthFactor: 0.8, // 70% del ancho del contenedor padre
                child: Container(
                  decoration: const BoxDecoration(
                    color: colorTertiary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                    ),
                  ),
                  child: Stack(children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        widget.text,
                        style: oswaldBlack.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeOverExtraLarge - 3),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
