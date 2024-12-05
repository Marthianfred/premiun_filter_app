import 'package:premium_filter/export.dart';

class PFButton3 extends StatelessWidget {
  const PFButton3(
      {super.key,
      required this.onPressed,
      required this.child,
      this.radius = Dimensions.radiusLarge,
      this.padding = const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault * 2)});

  final VoidCallback onPressed;
  final Widget child;
  final double radius;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: colorCuarto,
            border: Border.all(color: colorPrimary, width: 1),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius * 2),
                bottomRight: Radius.circular(radius)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: child,
        ),
      ),
    );
  }
}
