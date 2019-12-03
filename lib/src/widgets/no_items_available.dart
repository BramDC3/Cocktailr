import 'package:flutter/material.dart';

class NoItemsAvailable extends StatelessWidget {
  final String text;

  NoItemsAvailable(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Center(
        child: Text(text),
      ),
    );
  }
}