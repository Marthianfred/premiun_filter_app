import 'package:premium_filter/export.dart';

class CardEmptyTextWidget extends StatefulWidget {
  const CardEmptyTextWidget({
    super.key,
    required this.title,
    required this.textTitle,
  });

  final String title;
  final String textTitle;

  @override
  State<CardEmptyTextWidget> createState() => _CardEmptyTextWidgetState();
}

class _CardEmptyTextWidgetState extends State<CardEmptyTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  color: Colors.black,
                ),
                child: Center(
                  child: Text(
                    widget.title,
                    style: oswaldBold.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeExtraLarge),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: DropdownButtonHideUnderline(
                  child: buildText(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildText() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
      child: Text(widget.textTitle, style: nunitoRegular),
    );
  }
}
