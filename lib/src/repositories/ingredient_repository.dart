import 'package:cocktailr/src/bases/ingredient_source.dart';
import 'package:cocktailr/src/network/ingredient_api.dart';

class IngredientRepository {
  List<IngredientSource> sources = <IngredientSource>[
    IngredientApi(),
  ];

  List<String> _ingredients;
  Future<List<String>> get ingredients async {
    if (_ingredients == null || _ingredients.isEmpty) await _fetchIngredients();
    return _ingredients;
  }

  Future<void> _fetchIngredients() async {
    List<String> ingredients;

    for (final source in sources) {
      ingredients = await source.fetchIngredients();
      if (ingredients != null && ingredients.isNotEmpty) break;
    }

    _ingredients = ingredients ?? [];
  }
}
