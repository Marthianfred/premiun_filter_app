import 'package:premium_filter/export.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [colorPrimary, colorTertiary, colorPrimary],
        ),
      ),
      height: 100,
      child: Center(
        child: SvgPicture.asset(
          'assets/image/logo-full.svg',
        ),
      ),
    );
  }
}
