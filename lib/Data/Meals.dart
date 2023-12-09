class Meals {
  final String? strMeal;
  final String? strMealThumb;
  final String? idMeal;

  Meals({
    this.strMeal,
    this.strMealThumb,
    this.idMeal,
  });

  Meals.fromJson(Map<String, dynamic> json)
      : strMeal = json['strMeal'] as String?,
        strMealThumb = json['strMealThumb'] as String?,
        idMeal = json['idMeal'] as String?;

  Map<String, dynamic> toJson() => {
    'strMeal' : strMeal,
    'strMealThumb' : strMealThumb,
    'idMeal' : idMeal
  };
}