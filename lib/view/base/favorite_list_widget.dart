import 'package:premium_filter/export.dart';

class FavoriteListWidget extends StatefulWidget {
  const FavoriteListWidget({super.key, required this.title, required this.image});

  final String title;
  final Image image;
  @override
  State<FavoriteListWidget> createState() => _FavoriteListWidgetState();
}

class _FavoriteListWidgetState extends State<FavoriteListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget.image,
      title: Text(widget.title, style: oswaldRegular.copyWith(color: Colors.grey)),
    );
  }
}
