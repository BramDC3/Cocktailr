import 'package:cocktailr/src/blocs/cocktail_bloc.dart';
import 'package:cocktailr/src/blocs/ingredient_bloc.dart';
import 'package:cocktailr/src/constants/color_constants.dart';
import 'package:cocktailr/src/models/cocktail.dart';
import 'package:cocktailr/src/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'widgets/cocktail_alcoholic_label.dart';
import 'widgets/cocktail_ingredient_list_item.dart';
import 'widgets/cocktail_instructions.dart';
import 'widgets/cocktail_name.dart';
import 'widgets/cocktail_category.dart';

class CocktailDetailScreenMobile extends StatelessWidget {
  final String cocktailId;

  CocktailDetailScreenMobile({@required this.cocktailId});

  @override
  Widget build(BuildContext context) {
    final cocktailBloc = Provider.of<CocktailBloc>(context);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: StreamBuilder(
        stream: cocktailBloc.cocktails,
        builder: (context, AsyncSnapshot<Map<String, Future<Cocktail>>> snapshot) {
          if (!snapshot.hasData) {
            return LoadingSpinner();
          }

          return _buildCocktail(
            snapshot.data[cocktailId],
            width,
          );
        },
      ),
    );
  }

  Widget _buildCocktail(Future<Cocktail> cocktailFuture, double width) => FutureBuilder(
        future: cocktailFuture,
        builder: (context, AsyncSnapshot<Cocktail> snapshot) {
          if (!snapshot.hasData) {
            return LoadingSpinner();
          }

          return SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                _cocktailImage(snapshot.data, width),
                _goBackButton(context),
                _cocktailInfoContainer(snapshot.data, width),
              ],
            ),
          );
        },
      );

  Widget _cocktailImage(Cocktail cocktail, double width) => FadeInImage(
        image: NetworkImage(cocktail.image),
        placeholder: AssetImage(
          "assets/images/white_placeholder.png",
        ),
        width: width,
        height: width,
        fit: BoxFit.cover,
      );

  Widget _goBackButton(BuildContext context) => SafeArea(
        left: false,
        child: ButtonBar(
          alignment: MainAxisAlignment.start,
          children: <Widget>[
            _goBackButtonIcon(context),
          ],
        ),
      );

  Widget _goBackButtonIcon(BuildContext context) => Stack(
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

  Widget _cocktailInfoContainer(Cocktail cocktail, double width) => Container(
        width: width,
        margin: EdgeInsets.only(
          top: width * 9.5 / 10,
          bottom: 36,
        ),
        padding: EdgeInsets.only(top: width * 0.6 / 10),
        decoration: BoxDecoration(
          color: ColorConstants.defaultBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: _cocktailInfo(cocktail, width),
      );

  Widget _cocktailInfo(Cocktail cocktail, double width) => Column(
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
                    _cocktailName(cocktail, width),
                    SizedBox(height: 8),
                    _cocktailAlcoholicLabel(cocktail, width),
                    SizedBox(height: 12),
                    _cocktailIngredientList(cocktail, width),
                  ],
                ),
              ),
              CocktailCategory(
                width: width,
                cocktail: cocktail,
              ),
            ],
          ),
          SizedBox(height: 20),
          CocktailInstructions(
            instructions: cocktail.instructions,
            padding: width / 10,
          ),
        ],
      );

  Widget _cocktailName(Cocktail cocktail, double width) => Padding(
        padding: EdgeInsets.symmetric(horizontal: width / 10.5),
        child: CocktailName(cocktailName: cocktail.name),
      );

  Widget _cocktailAlcoholicLabel(Cocktail cocktail, double width) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width / 10,
        ),
        child: CocktailAlcoholicLabel(isAlcoholic: cocktail.isAlcoholic),
      );

  Widget _cocktailIngredientList(Cocktail cocktail, double width) => Padding(
        padding: EdgeInsets.only(left: width / 16, right: width / 10),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: cocktail.ingredients.length,
          itemBuilder: (context, index) {
            Provider.of<IngredientBloc>(context).fetchIngredient(cocktail.ingredients[index]);

            return CocktailIngredientListItem(
              ingredientName: cocktail.ingredients[index],
              measurement: index < cocktail.measurements.length ? cocktail.measurements[index] : "",
              isLastIngredient: index == cocktail.ingredients.length - 1,
            );
          },
        ),
      );
}
