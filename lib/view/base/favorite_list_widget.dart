import 'package:premium_filter/export.dart';

class FavoriteListWidget extends StatelessWidget {
  const FavoriteListWidget({
    super.key,
    required this.title,
    this.image,
    this.svgImage,
  });

  final String title;
  final Image? image;
  final SvgPicture? svgImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 40, // Definir el ancho y alto para controlar el tamaño
            height: 40,
            child: image ?? svgImage,
          ),
          const SizedBox(width: Dimensions.paddingSizeDefault),
          Expanded(
            child: Text(
              title,
              style: oswaldBold.copyWith(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
