import 'package:cocktailr/src/blocs/cocktail_bloc.dart';
import 'package:cocktailr/src/blocs/ingredient_bloc.dart';
import 'package:cocktailr/src/models/cocktail.dart';
import 'package:cocktailr/src/screens/cocktail_detail/desktop/widgets/cocktail_category_desktop.dart';
import 'package:cocktailr/src/screens/cocktail_detail/mobile/widgets/cocktail_alcoholic_label.dart';
import 'package:cocktailr/src/screens/cocktail_detail/mobile/widgets/cocktail_instructions.dart';
import 'package:cocktailr/src/screens/cocktail_detail/mobile/widgets/cocktail_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/cocktail_ingredient_list_item_desktop.dart';

class CocktailDetailScreenDesktop extends StatelessWidget {
  const CocktailDetailScreenDesktop({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cocktailBloc = Provider.of<CocktailBloc>(context);
    final width = 250.0;

    return Scaffold(
      body: StreamBuilder(
        stream: cocktailBloc.selectedCocktail,
        builder: (context, AsyncSnapshot<Cocktail> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          return _buildCocktail(snapshot.data, width);
        },
      ),
    );
  }

  Widget _buildCocktail(Cocktail cocktail, double width) => SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                _cocktailImage(cocktail, 250.0),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _cocktailName(cocktail, width),
                      _cocktailCategory(cocktail, width),
                      _cocktailAlcoholicLabel(cocktail, width),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _cocktailIngredientGrid(
              cocktail,
              width,
            ),
            SizedBox(height: 16),
            CocktailInstructions(
              instructions: cocktail.instructions,
              padding: width / 10,
            ),
          ],
        ),
      );

  Widget _cocktailImage(Cocktail cocktail, double height) => ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FadeInImage(
          width: height,
          height: height,
          image: NetworkImage(cocktail.image),
          placeholder: AssetImage(
            "assets/images/white_placeholder.png",
          ),
          fit: BoxFit.cover,
        ),
      );

  Widget _cocktailName(Cocktail cocktail, double width) => Padding(
        padding: EdgeInsets.symmetric(horizontal: width / 10.5),
        child: CocktailName(cocktailName: cocktail.name),
      );

  Widget _cocktailAlcoholicLabel(Cocktail cocktail, double width) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width / 10,
        ),
        child: CocktailAlcoholicLabel(
          isAlcoholic: cocktail.isAlcoholic,
        ),
      );

  Widget _cocktailCategory(Cocktail cocktail, double width) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width / 10,
        ),
        child: CocktailCategoryDesktop(
          category: cocktail.category,
        ),
      );

  Widget _cocktailIngredientGrid(Cocktail cocktail, double width) => Padding(
        padding: EdgeInsets.only(left: width / 16, right: width / 10),
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 2 / 1,
          ),
          itemCount: cocktail.ingredients.length,
          itemBuilder: (context, index) {
            Provider.of<IngredientBloc>(context).fetchIngredient(cocktail.ingredients[index]);

            return CocktailIngredientListItemDesktop(
              ingredientName: cocktail.ingredients[index],
              measurement: index < cocktail.measurements.length ? cocktail.measurements[index] : "",
              isLastIngredient: index == cocktail.ingredients.length - 1,
            );
          },
        ),
      );
}
