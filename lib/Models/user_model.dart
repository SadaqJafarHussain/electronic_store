class UserModel{
  final String name;
  final String email;
  final String image;
   String? address;

  UserModel({
    required this.email,
    required this.image,
    required this.name,
    this.address,
});

 factory UserModel.fromJso(Map<String,dynamic> json)=>UserModel(
    email:json['email'].toString(),
   name: json['name'].toString(),
   image: json['image'].toString(),
   address:json['address']??'',
 );
}