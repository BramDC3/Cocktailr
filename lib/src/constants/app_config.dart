// Networking
const int connectTimeout = 5000;
const int receiveTimeout = 5000;
const String baseUrl = 'https://www.thecocktaildb.com/api/json/v1/36578';
const String imageBaseUrl = 'https://www.thecocktaildb.com/images/ingredients';

// Languages
const String english = 'en';
const String dutch = 'nl';
const String french = 'fr';

// Countries
const String belgium = 'BE';

// Boxes
const String cocktailBoxName = 'Cocktails';
const String ingredientBoxName = 'Ingredients';

// Fonts
const String roboto = 'Roboto';

// Cocktails
const String defaultIngredient = 'Tequila';
const String defaultCocktailId = '11002';
const List<String> popularCocktailIds = ['11002', '11001', '11000', '13621', '17207'];
const List<String> trendingIngredients = ['Tequila', 'Vodka', 'Rum', 'Gin', 'Whiskey'];

// Files
const String environmentVariablesFilePath = '.env';

// Environment variable keys
const String sentryKey = 'SENTRY_KEY';
