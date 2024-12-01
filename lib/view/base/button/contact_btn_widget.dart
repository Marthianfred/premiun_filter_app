import 'package:premium_filter/export.dart';

class ContactBtnWidget extends StatefulWidget {
  const ContactBtnWidget({
    super.key,
    required this.image,
    required this.text,
    this.isPrincipal = false,
    this.onTap,
  });

  final SvgPicture image;
  final String text;
  final bool isPrincipal;
  final VoidCallback? onTap;

  @override
  State<ContactBtnWidget> createState() => _ContactBtnWidgetState();
}

class _ContactBtnWidgetState extends State<ContactBtnWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: widget.isPrincipal ? 200 : 120,
            height: widget.isPrincipal ? 140 : 110,
            decoration: widget.isPrincipal
                ? BoxDecoration(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: shadowLight.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  )
                : const BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    gradient: RadialGradient(
                      center: Alignment(0, 0), // near the top right
                      radius: 0.5,
                      colors: [colorPrimary, colorTertiary, colorPrimary],
                      stops: [0.1, 0.5, 0.9],
                    ),
                  ),
            child: widget.image,
          ),
          Container(
            width: widget.isPrincipal ? 200 : 120,
            height: widget.isPrincipal ? 60 : 40,
            decoration: widget.isPrincipal
                ? const BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                    gradient: RadialGradient(
                      center: Alignment(0, 0), // near the top right
                      radius: 0.5,
                      colors: [colorPrimary, colorTertiary, colorPrimary],
                      stops: [0.1, 0.5, 0.9],
                    ),
                  )
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: shadowLight.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
            child: Center(
                child: Text(
              widget.text.toUpperCase(),
              style: oswaldRegular.copyWith(
                color: widget.isPrincipal ? Colors.white : colorPrimary,
                fontSize: widget.isPrincipal ? Dimensions.fontSizeDefault : Dimensions.fontSizeExtraSmall,
              ),
              textAlign: TextAlign.center,
            )),
          )
        ],
      ),
    );
  }
}
