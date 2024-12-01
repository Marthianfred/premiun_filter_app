import 'package:premium_filter/export.dart';

class PFButton2 extends StatelessWidget {
  const PFButton2({
    super.key,
    required this.onPressed,
    required this.child,
    this.radius = Dimensions.radiusLarge,
    this.padding = const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault * 2)
  });

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
            gradient: const LinearGradient(
              colors: [
                colorCuarto,
                colorQuinto,
                colorCuarto,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            boxShadow: [
              BoxShadow(
                color: colorPrimary.withOpacity(0.6),
                blurRadius: 6,
                offset: const Offset(4, 6),
              ),
            ],
            border: Border.all(color: colorPrimary, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(radius)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: child,
              )
            ],
          ),
        ),
      ),
    );
  }
}
