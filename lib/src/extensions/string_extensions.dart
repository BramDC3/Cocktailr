const int maxBits = 128;

// extension StringExtensions on String {
//   bool get containsNoUnicodeCharacters {
//     List<int> unicodeSymbols = this.codeUnits.where((ch) => ch > maxBits).toList();
//     return unicodeSymbols.length == 0;
//   }
// }

class StringExtensions {
  static bool containsNoUnicodeCharacters(String text) {
    final List<int> nonAsciiCharacters = text.codeUnits.where((ch) => ch > maxBits).toList();
    return nonAsciiCharacters.length == 0;
  }
}
