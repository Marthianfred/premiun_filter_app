import 'package:premium_filter/export.dart';

// class SplashMobileScreen extends StatefulWidget {
//   const SplashMobileScreen({super.key});
//
//   @override
//   State<SplashMobileScreen> createState() => _SplashMobileScreenState();
// }
//
// class _SplashMobileScreenState extends State<SplashMobileScreen> with SingleTickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.centerLeft,
//           end: Alignment.centerRight,
//           colors: [colorPrimary, colorTertiary, colorPrimary],
//         ),
//       ),
//       child: Stack(
//         children: [
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
//               child: Image.asset(
//                 'assets/image/logo_full.png',
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class SplashMobileScreen extends StatefulWidget {
  const SplashMobileScreen({super.key});

  @override
  State<SplashMobileScreen> createState() => _SplashMobileScreenState();
}

class _SplashMobileScreenState extends State<SplashMobileScreen> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    )..repeat();

    route();
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  void route() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offAllNamed(RouteHelper.getLanguageRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [colorPrimary, colorTertiary, colorPrimary],
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
              child: SvgPicture.asset(
                'assets/image/logo-full.svg',
              ),
            ),
          ),
        ],
      ),
    );
  }
}