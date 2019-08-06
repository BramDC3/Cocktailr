class Cocktail {
  final String id;
  final String name;
  final String category;
  final String instructions;
  final String image;
  final List<String> ingredients;
  final List<String> measurements;

  Cocktail({
    this.id,
    this.name,
    this.category,
    this.instructions,
    this.image,
    this.ingredients,
    this.measurements,
  });

  factory Cocktail.fromJson(Map<String, dynamic> json) {
    return Cocktail(
      id: json['idDrink'],
      name: json['strDrink'],
      category: json['strCategory'],
      instructions: json['strInstructions'],
      image: json['strDrinkThumb'],
      ingredients: toList(json, 'strIngredient'),
      measurements: toList(json, 'strMeasure'),
    );
  }

  static List<String> toList(Map<String, dynamic> json, String tag) {
    List<String> list = List.generate(15, (int i) => json['$tag${i + 1}']);
    list.removeWhere((i) => i == '' || i == ' ' || i == '\n' || i == null);
    return list;
  }
}
