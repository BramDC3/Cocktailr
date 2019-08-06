import 'package:cocktailr/src/models/bases/bloc_base.dart';
import 'package:cocktailr/src/models/cocktail.dart';
import 'package:cocktailr/src/repositories/cocktail_repository.dart';
import 'package:rxdart/rxdart.dart';

class CocktailBloc extends BlocCase {
  final _cocktailRepository;
  final _cocktailIds = BehaviorSubject<List<String>>();
  final _ingredients = BehaviorSubject<List<String>>();
  final _cocktailsOutput = BehaviorSubject<Map<String, Future<Cocktail>>>();
  final _cocktailsFetcher = PublishSubject<String>();

  Observable<List<String>> get cocktailIds => _cocktailIds.stream;
  Observable<List<String>> get ingredients => _ingredients.stream;
  Observable<Map<String, Future<Cocktail>>> get cocktails => _cocktailsOutput.stream;

  Function(String) get fetchCocktail => _cocktailsFetcher.sink.add;

  CocktailBloc({CocktailRepository cocktailRepository})
      : _cocktailRepository = cocktailRepository ?? CocktailRepository() {
    _cocktailsFetcher.stream.transform(_cocktailsTransformer()).pipe(_cocktailsOutput);
    _fetchIngredients();
    fetchCocktailIdsByIngredient("Gin");
  }

  Future<void> _fetchIngredients() async {
    List<String> ingredients = await _cocktailRepository.ingredients;
    _ingredients.sink.add(ingredients);
  }

  Future<void> fetchCocktailIdsByIngredient(String ingredient) async {
    _cocktailIds.sink.add(null);
    List<String> cocktailsIds =
        await _cocktailRepository.fetchCocktailIdsByIngredient(ingredient);
    _cocktailIds.sink.add(cocktailsIds);
  }

  Future<Cocktail> _fetchCockailById(String cocktailId) async =>
      _cocktailRepository.fetchCocktailById(cocktailId);

  _cocktailsTransformer() {
    return ScanStreamTransformer(
      (Map<String, Future<Cocktail>> cache, String id, _) {
        cache[id] = _fetchCockailById(id);
        return cache;
      },
      <String, Future<Cocktail>>{},
    );
  }

  @override
  void dispose() {
    _cocktailIds.close();
    _cocktailsOutput.close();
    _cocktailsFetcher.close();
    _ingredients.close();
  }
}
