import 'package:flutter/material.dart';

Widget loadingSpinner() => Container(
      padding: EdgeInsets.all(8),
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(
            Colors.red,
          ),
        ),
      ),
    );
