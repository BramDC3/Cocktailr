import 'package:flutter/material.dart';

class ClearFieldIcon extends StatelessWidget {
  final String keyword;
  final Color color;
  final Function onPressed;

  const ClearFieldIcon({
    @required this.keyword,
    @required this.color,
    @required this.onPressed,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (keyword == null || keyword == "") {
      return Container();
    }

    return IconButton(
      icon: Icon(
        Icons.clear,
        color: color,
      ),
      tooltip: "Clear entry",
      onPressed: onPressed,
    );
  }
}
