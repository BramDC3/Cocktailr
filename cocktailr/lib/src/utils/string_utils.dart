class StringUtils {
  static String capitalizeWord(String word) {
    if (word == null || word.length <= 1) return word;
    return "${word[0].toUpperCase()}${word.substring(1)}";
  }

  static String getCategory(String category) {
    switch (category) {
      case "Ordinary Drink":
        return "Mundane";
      case "Cocktail":
        return "Cocktail";
      case "Milk \/ Float \/ Shake":
        return "Milkshake";
      case "Other\/Unknown":
        return "Mundane";
      case "Cocoa":
        return "Cocoa";
      case "Shot":
        return "Shot";
      case "Coffee \/ Tea":
        return "Coffee / Tea";
      case "Homemade Liqueur":
        return "Liqueur";
      case "Punch \/ Party Drink":
        return "Party Drink";
      case "Beer":
        return "Beer";
      case "Soft Drink \/ Soda":
        return "Soda";
      default:
        return "Mundane";
    }
  }
}
