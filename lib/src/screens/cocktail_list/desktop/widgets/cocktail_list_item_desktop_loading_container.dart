import 'package:flutter/material.dart';

class CocktailListItemDesktopLoadingContainer extends StatelessWidget {
  const CocktailListItemDesktopLoadingContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = 100.0;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {},
        child: Container(
          child: Row(
            children: <Widget>[
              _cocktailImage(height),
              Expanded(
                child: _cocktailDetails(height),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cocktailImage(double height) => Container(
        width: height,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
      );

  Widget _cocktailDetails(double height) => Container(
        height: height,
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: height / 6,
              width: height * 1.5,
              color: Colors.grey[200],
            ),
            Container(
              height: height / 3.5,
              width: double.infinity,
              color: Colors.grey[200],
            ),
          ],
        ),
      );
}
