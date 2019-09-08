import 'package:cocktailr/src/models/cocktail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Capitalize name of cocktail', () {
    test('Input is null, return value is empty string', () {
      String capitalizedName = Cocktail.capitalizeName(null);
      expect(capitalizedName, '');
    });

    test('Input is an empty string, return value is empty string', () {
      String capitalizedName = Cocktail.capitalizeName('');
      expect(capitalizedName, '');
    });

    test('Input has no letters, return value is parameter', () {
      String capitalizedName = Cocktail.capitalizeName('#@-)28387329^');
      expect(capitalizedName, '#@-)28387329^');
    });

    test('Input is one word, return value is capitalized word', () {
      String capitalizedName = Cocktail.capitalizeName('cocktail');
      expect(capitalizedName, 'Cocktail');
    });

    test(
        'Input has whitespaces before and after, return value is trimmed capitalized word',
        () {
      String capitalizedName = Cocktail.capitalizeName('    my cocktail    ');
      expect(capitalizedName, 'My Cocktail');
    });

    test(
        'Input has multiple spaces between multiple words, return value is capitalized name',
        () {
      String capitalizedName =
          Cocktail.capitalizeName('   this    is  a     test     ');
      expect(capitalizedName, 'This Is A Test');
    });

    test('Input has multiple words, return value is capitalized name', () {
      String capitalizedName = Cocktail.capitalizeName('this is a test');
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
    test('Input is null, return value is empty array', () {
      List<String> filteredList = Cocktail.filterList(null, 'ingredient');
      expect(filteredList, []);
    });

    test('Input is empty map, return value is empty array', () {
      List<String> filteredList =
          Cocktail.filterList(Map<String, dynamic>(), 'ingredient');
      expect(filteredList, []);
    });
  });
}
