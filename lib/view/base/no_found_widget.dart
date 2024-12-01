import 'package:premium_filter/export.dart';

class NoFoundWidget extends StatelessWidget{
  const NoFoundWidget({super.key, this.callBack, required this.message});

  final Function? callBack;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () => callBack!(),
        child: Row(
          children: [
            const Icon(Icons.error, color: colorError, size: 20),
            const SizedBox(width: Dimensions.paddingSizeSmall),
            Text(message, style: oswaldRegular.copyWith(color: colorError)),
          ],
        ),
      ),
    );
  }
}
