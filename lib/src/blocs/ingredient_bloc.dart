import 'package:cocktailr/src/bases/bloc_base.dart';
import 'package:cocktailr/src/repositories/ingredient_repository.dart';
import 'package:rxdart/rxdart.dart';

class IngredientBloc extends BlocBase {
  final _ingredientRepository = IngredientRepository();
  final _ingredients = BehaviorSubject<List<String>>();

  Observable<List<String>> get ingredients => _ingredients.stream;

  IngredientBloc() {
    _fetchIngredients();
  }

  Future<void> _fetchIngredients() async {
    List<String> ingredients = await _ingredientRepository.ingredients;
    _ingredients.sink.add(ingredients);
  }

  @override
  void dispose() {
    _ingredients.close();
  }
}
