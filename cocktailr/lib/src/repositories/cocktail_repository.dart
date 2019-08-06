import 'package:cocktailr/src/models/cocktail.dart';
import 'package:cocktailr/src/network/cocktail_api.dart';

class CocktailRepository {
  final CocktailApi _cocktailApi;

  CocktailRepository({CocktailApi cocktailApi})
      : _cocktailApi = cocktailApi ?? CocktailApi();

  List<String> _ingredients;
  Future<List<String>> get ingredients async {
    if (_ingredients == null || _ingredients.isEmpty) await _fetchIngredients();
    return _ingredients;
  }

  Future<void> _fetchIngredients() async =>
      _ingredients = await _cocktailApi.fetchIngredients();

  Future<List<String>> fetchCocktailIdsByIngredient(String ingredient) async =>
      _cocktailApi.fetchCocktailIdsByIngredient(ingredient);

  Future<Cocktail> fetchCocktailById(String cocktailId) async =>
      _cocktailApi.fetchCocktailById(cocktailId);
}
