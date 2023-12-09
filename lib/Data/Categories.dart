
class Categories {
  final String? idCategory;
  final String? strCategory;
  final String? strCategoryThumb;
  final String? strCategoryDescription;

  Categories({
    this.idCategory,
    this.strCategory,
    this.strCategoryThumb,
    this.strCategoryDescription,
  });

  Categories.fromJson(Map<String, dynamic> json)
      : idCategory = json['idCategory'] as String?,
        strCategory = json['strCategory'] as String?,
        strCategoryThumb = json['strCategoryThumb'] as String?,
        strCategoryDescription = json['strCategoryDescription'] as String?;

  Map<String, dynamic> toJson() => {
    'idCategory' : idCategory,
    'strCategory' : strCategory,
    'strCategoryThumb' : strCategoryThumb,
    'strCategoryDescription' : strCategoryDescription
  };
}