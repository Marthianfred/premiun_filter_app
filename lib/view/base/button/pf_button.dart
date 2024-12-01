import 'package:premium_filter/export.dart';

class PFButton extends StatelessWidget {
  const PFButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault * 2),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          height: 70,
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
            borderRadius: const BorderRadius.all(Radius.circular(32)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: child,
              ),
              Positioned(
                right: Dimensions.paddingSizeDefault,
                top: Dimensions.paddingSizeSmall - 4,
                child: SvgPicture.asset(
                  "assets/image/btn_arrow.svg",
                  height: 40,
                  colorFilter: const ColorFilter.mode(colorPrimary, BlendMode.srcIn),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}