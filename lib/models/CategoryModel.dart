


class CategoryModel {
  CategoryModel({
      this.id, 
      this.name, 
      this.image, 
      this.icon,});

  CategoryModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    icon = json['icon'];
  }
  int? id;
  String? name;
  String? image;
  String? icon;

}