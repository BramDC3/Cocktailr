import 'package:cached_network_image/cached_network_image.dart';
import 'package:cocktailr/src/blocs/cocktail_bloc.dart';
import 'package:cocktailr/src/constants/color_constants.dart';
import 'package:cocktailr/src/models/cocktail.dart';
import 'package:cocktailr/src/screens/cocktail_detail/widgets/cocktail_alcoholic_label.dart';
import 'package:cocktailr/src/screens/cocktail_detail/widgets/cocktail_name.dart';
import 'package:cocktailr/src/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'widgets/cocktail_category.dart';
import 'widgets/cocktail_instructions.dart';

class CocktailDetailScreen extends StatelessWidget {
  CocktailDetailScreen({@required this.cocktailId});
  final String cocktailId;

  @override
  Widget build(BuildContext context) {
    final cocktailBloc = Provider.of<CocktailBloc>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
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
                physics: ClampingScrollPhysics(),
                child: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    FadeInImage(
                      image: CachedNetworkImageProvider("${cocktailSnapshot.data.image}"),
                      placeholder: AssetImage("assets/images/ingredients/white_placeholder.png"),
                      width: screenWidth,
                      height: screenWidth,
                      fit: BoxFit.cover,
                    ),
                    SafeArea(
                      left: false,
                      child: ButtonBar(
                        alignment: MainAxisAlignment.start,
                        children: <Widget>[
                          _goBackButton(context),
                        ],
                      ),
                    ),
                    Container(
                      width: screenWidth,
                      margin: EdgeInsets.only(
                        top: screenWidth * 9.5 / 10,
                        bottom: 36,
                      ),
                      padding: EdgeInsets.only(
                        top: screenWidth * 0.6 / 10,
                      ),
                      decoration: BoxDecoration(
                        color: ColorConstants.defaultBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth / 10.5,
                                      ),
                                      child: CocktailName(
                                        cocktailName:
                                            cocktailSnapshot.data.name,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth / 10,
                                      ),
                                      child: CocktailAlcoholicLabel(
                                        isAlcoholic:
                                            cocktailSnapshot.data.isAlcoholic,
                                      ),
                                    ),
                                    SizedBox(height: 32),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth / 10,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: _buildIngredientList(
                                          cocktailSnapshot.data,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              CocktailCategory(
                                width: screenWidth,
                                cocktail: cocktailSnapshot.data,
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          CocktailInstructions(
                            instructions: cocktailSnapshot.data.instructions,
                            padding: screenWidth / 10,
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
    );
  }

  List<Widget> _buildIngredientList(Cocktail cocktail) {
    List<Widget> ingredientListItems = [];

    for (int i = 0; i < cocktail.ingredients.length; i++) {
      ingredientListItems.add(
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(cocktail.ingredients[i]),
              ),
              SizedBox(height: 4),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  i < cocktail.measurements.length
                      ? cocktail.measurements[i]
                      : "",
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      if (i + 1 != cocktail.ingredients.length) {
        ingredientListItems.add(Divider());
      }
    }

    return ingredientListItems;
  }

  Widget _goBackButton(BuildContext context) => Stack(
        children: <Widget>[
          IconButton(
            tooltip: "Go back",
            onPressed: Navigator.of(context).pop,
            icon: Icon(
              FontAwesomeIcons.chevronLeft,
              color: Colors.white,
              size: 26,
            ),
          ),
          IconButton(
            tooltip: "Go back",
            onPressed: Navigator.of(context).pop,
            icon: Icon(
              FontAwesomeIcons.chevronCircleLeft,
              color: Colors.black87,
              size: 26,
            ),
          ),
        ],
      );
}
