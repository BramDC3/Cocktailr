import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Colors.white
          ),
          decoration: InputDecoration(
            hintText: "Search by ingredient...",
            hintStyle: TextStyle(color: Colors.white70),
          ),
        ),
      ),
    );
  }
}