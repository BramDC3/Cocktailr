import 'package:cocktailr/src/models/cocktail.dart';
import 'package:cocktailr/src/utils/string_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Capitalize name of cocktail', () {
    test('Input is null, return value is empty string', () {
      String capitalizedName = capitalizeAllWords(null);
      expect(capitalizedName, '');
    });

    test('Input is an empty string, return value is empty string', () {
      String capitalizedName = capitalizeAllWords('');
      expect(capitalizedName, '');
    });

    test('Input has no letters, return value is parameter', () {
      String capitalizedName = capitalizeAllWords('#@-)28387329^');
      expect(capitalizedName, '#@-)28387329^');
    });

    test('Input is one word, return value is capitalized word', () {
      String capitalizedName = capitalizeAllWords('cocktail');
      expect(capitalizedName, 'Cocktail');
    });

    test(
        'Input has whitespaces before and after, return value is trimmed capitalized word',
        () {
      String capitalizedName = capitalizeAllWords('    my cocktail    ');
      expect(capitalizedName, 'My Cocktail');
    });

    test(
        'Input has multiple spaces between multiple words, return value is capitalized name',
        () {
      String capitalizedName =
          capitalizeAllWords('   this    is  a     test     ');
      expect(capitalizedName, 'This Is A Test');
    });

    test('Input has multiple words, return value is capitalized name', () {
      String capitalizedName = capitalizeAllWords('this is a test');
      expect(capitalizedName, 'This Is A Test');
    });
  });

  group('Refactor cocktail category', () {
    test('Input is null, return value is default value', () {
      String refactoredCategory = Cocktail.refactorCategory(null);
      expect(refactoredCategory, 'Mundane');
    });

    test('Input is empty string, return value is default value', () {
      String refactoredCategory = Cocktail.refactorCategory("");
      expect(refactoredCategory, 'Mundane');
    });

    test('Input has no letters, return value is default value', () {
      String refactoredCategory = Cocktail.refactorCategory("#@-)28387329^");
      expect(refactoredCategory, 'Mundane');
    });

    test('Input is not recognized, return value is default value', () {
      String refactoredCategory = Cocktail.refactorCategory("Awesome Cocktail");
      expect(refactoredCategory, 'Mundane');
    });

    test('Input has whitespace, return value is appropriate category', () {
      String refactoredCategory = Cocktail.refactorCategory(" party Drink  ");
      expect(refactoredCategory, 'Party Drink');
    });

    test('Input is recognized, return value is appropriate category', () {
      String refactoredCategory = Cocktail.refactorCategory("Cocoa");
      expect(refactoredCategory, 'Cocoa');
    });
  });

  group('Filter cocktail list (ingredients & measurements)', () {
    test('Input map and tag are null, return value is empty list', () {
      List<String> filteredList = Cocktail.filterList(null, null);
      expect(filteredList, []);
    });

    test('Input map is null, return value is empty arrlistay', () {
      List<String> filteredList = Cocktail.filterList(null, 'ingredient');
      expect(filteredList, []);
    });

    test('Input tag is null, return value is empty list', () {
      List<String> filteredList = Cocktail.filterList(Map<String, String>(), null);
      expect(filteredList, []);
    });

    test('Input map and tag are empty, return value is empty list', () {
      List<String> filteredList = Cocktail.filterList(Map<String, String>(), '');
      expect(filteredList, []);
    });

    test('Input map is empty, return value is empty list', () {
      List<String> filteredList = Cocktail.filterList(Map<String, String>(), 'ingredient');
      expect(filteredList, []);
    });

    test('Input and tag are valid, return is filtered list', () {
      String tag = "ingredient";

      Map<String, String> json = Map.fromEntries([
        MapEntry<String, String>("${tag}1", "Vodka"),
        MapEntry<String, String>("${tag}2", "Light rum"),
        MapEntry<String, String>("${tag}3", "Gin"),
        MapEntry<String, String>("${tag}4", "Tequila"),
        MapEntry<String, String>("${tag}5", "Lemon"),
        MapEntry<String, String>("${tag}6", "Coca-Cola"),
      ]);

      List<String> filteredList = Cocktail.filterList(json, tag);
      expect(filteredList.length, 6);
      expect(filteredList.where((i) => i == '' || i == ' ' || i == '\n' || i == null).toList().length, 0);
    });
  });
}
