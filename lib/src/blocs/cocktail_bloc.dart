import 'package:cocktailr/src/bases/bloc_base.dart';
import 'package:cocktailr/src/models/cocktail.dart';
import 'package:cocktailr/src/repositories/cocktail_repository.dart';
import 'package:rxdart/rxdart.dart';

class CocktailBloc extends BlocBase {
  final _cocktailRepository = CocktailRepository();
  final _cocktailIds = BehaviorSubject<List<String>>();
  final _popularCocktailIds = BehaviorSubject<List<String>>();
  final _cocktailsOutput = BehaviorSubject<Map<String, Future<Cocktail>>>();
  final _cocktailsFetcher = BehaviorSubject<String>();
  final _selectedCocktail = BehaviorSubject<Cocktail>();

  Observable<List<String>> get cocktailIds => _cocktailIds.stream;
  Observable<List<String>> get popularCocktailIds => _popularCocktailIds;
  Observable<Map<String, Future<Cocktail>>> get cocktails => _cocktailsOutput.stream;
  Observable<Cocktail> get selectedCocktail => _selectedCocktail.stream;

  Function(String) get fetchCocktail => _cocktailsFetcher.sink.add;
  Function(Cocktail) get selectCocktail => _selectedCocktail.sink.add;

  CocktailBloc() {
    _cocktailsFetcher.stream
        .transform(_cocktailsTransformer())
        .pipe(_cocktailsOutput);
    _fetchPopularCocktailIds();
    fetchCocktailIdsByIngredient("Tequila");
  }

  Future<void> fetchCocktailIdsByIngredient(String ingredient) async {
    _cocktailIds.sink.add(null);
    List<String> cocktailIds = await _cocktailRepository.fetchCocktailIdsByIngredient(ingredient);
    _cocktailIds.sink.add(cocktailIds);
  }

  Future<Cocktail> fetchRandomCocktail() async => _cocktailRepository.fetchRandomCocktail();

  Future<void> _fetchPopularCocktailIds() async {
    List<String> popularCocktailIds = await _cocktailRepository.fetchPopularCocktailIds();
    _popularCocktailIds.sink.add(popularCocktailIds);
  }

  Future<Cocktail> _fetchCockailById(String cocktailId) async => _cocktailRepository.fetchCocktailById(cocktailId);

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
    _popularCocktailIds.close();
    _cocktailsOutput.close();
    _cocktailsFetcher.close();
    _selectedCocktail.close();
  }
}
