class CategoryModel {
  String? categoryID;
  String? name;

  CategoryModel({
    this.categoryID,
    this.name,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoryID = json['categoryID'];
    name = json['name'];
  }

  Map<String, dynamic> toMap() {
    return {
      'categoryID': categoryID,
      'name': name,
    };
  }
}
