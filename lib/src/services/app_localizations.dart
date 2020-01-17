import 'package:cocktailr/l10n/messages_all.dart';
import 'package:cocktailr/src/constants/app_strings.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:cocktailr/src/extensions/string_extensions.dart';

class AppLocalizations {
  static AppLocalizations current;

  AppLocalizations._(Locale locale) {
    current = this;
  }

  static Future<AppLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isNullOrEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalizations._(locale);
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // General
  String get appTitle => Intl.message('Cocktailr', name: 'appTitle');

  // Buttons
  String get buttonTooltipGoBack => Intl.message('Go back', name: 'buttonTooltipGoBack');

  // Cocktail detail screen
  String get cocktailDetailLabelAlcoholic => Intl.message('Alcoholic', name: 'cocktailDetailLabelAlcoholic');
  String get cocktailDetailLabelNonAlcoholic => Intl.message('Non-alcoholic', name: 'cocktailDetailLabelNonAlcoholic');
  String get cocktailDetailLabelHowToPrepare =>
      Intl.message('How to prepare:', name: 'cocktailDetailLabelHowToPrepare');

  // Cocktail list screen
  String get cocktailListErrorNoCocktailsAvailable =>
      Intl.message('There are currently no cocktailt available', name: cocktailListErrorNoCocktailsAvailable);
  
  // Home screen
  String get homeLabelTrendingCocktails => Intl.message('Trending Cocktails', name: homeLabelTrendingCocktails);
  String get homeLabelPopularIngredients => Intl.message('Popular Ingredients', name: homeLabelPopularIngredients);
  String get homeLabelMysteryCocktail => Intl.message('Mystery Cocktail', name: homeLabelMysteryCocktail);
  String get homeButtonMysteryCocktail => Intl.message("I'm feeling lucky", name: homeButtonMysteryCocktail);

  // Search screen
  String get searchPlaceHolderSearchText => Intl.message('Search by ingredient...', name: searchPlaceHolderSearchText);
  String get searchButtonClearEntry => Intl.message('Clear entry', name: searchButtonClearEntry);

  // Main screen
  String get navigationLabelHomeScreen => Intl.message('Explore', name: navigationLabelHomeScreen);
  String get navigationLabelCocktailScreen => Intl.message('Cocktails', name: navigationLabelCocktailScreen);
  String get mainButtonLabelSearch => Intl.message('Search cocktails', name: mainButtonLabelSearch);
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => [english, dutch, french].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
