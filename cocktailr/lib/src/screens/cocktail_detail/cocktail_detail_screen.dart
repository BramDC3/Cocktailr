import 'package:cocktailr/src/blocs/cocktail_bloc.dart';
import 'package:cocktailr/src/models/cocktail.dart';
import 'package:cocktailr/src/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CocktailDetailScreen extends StatelessWidget {
  final String cocktailId;

  CocktailDetailScreen({@required this.cocktailId});

  List<TableRow> _createTable(Cocktail cocktail) {
    List<TableRow> tableList = [];
    tableList.add(
      TableRow(
        children: [
          Padding(
            child: Text(
              "INGREDIENT",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            padding: EdgeInsets.all(4),
          ),
          Padding(
            child: Text(
              "MEASUREMENT",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            padding: EdgeInsets.all(4),
          )
        ],
      ),
    );
    for (int i = 0; i < cocktail.ingredients.length; i++) {
      tableList.add(
        TableRow(
          children: [
            Padding(
              child: Text(cocktail.ingredients[i]),
              padding: EdgeInsets.all(4),
            ),
            Padding(
              child: Text(i < cocktail.measurements.length
                  ? cocktail.measurements[i]
                  : ''),
              padding: EdgeInsets.all(4),
            )
          ],
        ),
      );
    }
    return tableList;
  }

  @override
  Widget build(BuildContext context) {
    final cocktailBloc = Provider.of<CocktailBloc>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      child: Scaffold(
        body: StreamBuilder(
          stream: cocktailBloc.cocktails,
          builder:
              (context, AsyncSnapshot<Map<String, Future<Cocktail>>> snapshot) {
            if (!snapshot.hasData) {
              return loadingSpinner();
            }

            return FutureBuilder(
              future: snapshot.data[cocktailId],
              builder: (context, AsyncSnapshot<Cocktail> cocktailSnapshot) {
                if (!cocktailSnapshot.hasData) {
                  return loadingSpinner();
                }

                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      _cocktailHeader(
                        cocktailSnapshot.data,
                        screenWidth,
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: <Widget>[
                            Text(
                              cocktailSnapshot.data.name,
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Category: ${cocktailSnapshot.data.category}",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 12),
                            Text(cocktailSnapshot.data.instructions),
                            SizedBox(height: 12),
                            Table(
                              border: TableBorder.all(),
                              children: _createTable(cocktailSnapshot.data),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _cocktailHeader(Cocktail cocktail, double width) => Stack(
        children: <Widget>[
          Container(height: width + width / 14),
          _cocktailImage(cocktail, width),
          _favoriteButton(width),
        ],
      );

  Widget _cocktailImage(Cocktail cocktail, double width) => ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(60),
        ),
        child: Image.network(
          cocktail.image,
          width: width,
          height: width,
        ),
      );

  Widget _favoriteButton(double width) => Positioned(
            bottom: 0,
            right: width / 14,
            child: SizedBox(
              height: width / 7,
              width: width / 7,
              child: RawMaterialButton(
                onPressed: () {},
                shape: CircleBorder(),
                fillColor: Color(0xFFFA7574),
                highlightElevation: 4,
                highlightColor: Colors.redAccent,
                child: Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: width / 16,
                ),
              ),
            ),
          );
}
