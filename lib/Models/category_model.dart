class CategoryModel{
  final int id;
  final String name;
  final String image;

  CategoryModel({
    required this.name,
    required this.id,
    required this.image
});

  factory CategoryModel.fromJson(Map<String,dynamic> json)=>CategoryModel(
      name: json['name'].toString(),
      id: json['id'],
      image: json['url_image'].toString(),
  );
}