import 'package:premium_filter/export.dart';

class CardTextFieldWithIconWidget extends StatefulWidget {
  const CardTextFieldWithIconWidget({
    super.key,
    required this.title,
    required this.textTitle,
    required this.controller,
  });

  final String title;
  final String textTitle;
  final TextEditingController controller;

  @override
  State<CardTextFieldWithIconWidget> createState() => _CardTextFieldWithIconWidgetState();
}

class _CardTextFieldWithIconWidgetState extends State<CardTextFieldWithIconWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
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
                child: buildText(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<String?> showCameraDialog(BuildContext context) async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return const BarcodeScannerWithOverlay();
      },
    );
  }

  Widget buildText() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
        child: TextField(
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9-]')), // Permite solo letras y números
            UpperCaseTextFormatter(),
          ],
          controller: widget.controller,
          style: nunitoRegular.copyWith(color: Colors.black),
          decoration: InputDecoration(
              prefixIcon: ValueListenableBuilder<TextEditingValue>(
                valueListenable: widget.controller,
                builder: (BuildContext context, TextEditingValue value, Widget? child) {
                  return value.text.isEmpty
                      ? IconButton(
                          onPressed: () async => widget.controller.text = await showCameraDialog(context) ?? "",
                          icon: const Icon(Icons.camera_alt_outlined, color: colorPrimary),
                        )
                      : IconButton(
                          onPressed: () async {
                            await Get.find<FindController>().getSrReferences(pfRef: widget.controller.text);
                            Get.toNamed(RouteHelper.getSingleProductRoute());
                          },
                          icon: const Icon(Icons.search, color: colorPrimary),
                        );
                },
              ),
              suffixIcon: IconButton(
                onPressed: () => widget.controller.clear(),
                icon: const Icon(Icons.clear),
              ),
              hintText: widget.textTitle,
              hintStyle: nunitoRegular.copyWith(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.transparent),
              )),
        ));
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
