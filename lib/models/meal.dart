enum Complexity {
  Simple,
  Challenging,
  Hard,
}

enum Affordability {
  Affordable,
  Pricey,
  Luxurious,
}

class Meal {
  final String id;
  final List<String> categories;

  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;

  final Complexity complexity;
  final Affordability affordability;
  final int duration;

  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  const Meal({
    required this.id,
    required this.categories,
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.complexity,
    required this.affordability,
    required this.duration,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json["id"],
      categories: json["categories"],
      title: json["title"],
      imageUrl: json["imageUrl"],
      ingredients: json["ingredients"],
      steps: json["steps"],
      complexity: json["complexity"],
      affordability: json["affordability"],
      duration: json["duration"],
      isGlutenFree: json["isGlutenFree"],
      isLactoseFree: json["isLactoseFree"],
      isVegan: json["isVegan"],
      isVegetarian: json["isVegetarian"],
    );
  }
}
