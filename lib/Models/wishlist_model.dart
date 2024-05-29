
class WishListModel{
  final int productId;
  final String productTitle;
  final String productImage;
  final String productDesc;
  final String userId;
  final String productPrice;

  WishListModel({
    required this.productId,
    required this.productDesc,
    required this.productImage,
    required this.productPrice,
    required this.userId,
    required this.productTitle,
  });
  factory WishListModel.fromJson(Map<String, dynamic> json) => WishListModel(
    productId:json['product_id'],
    productDesc: json['descripe'].toString(),
    productImage:  json['image'].toString(),
    productPrice: json["price"].toString(),
    userId: json['user_id'].toString(),
    productTitle: json['product_name'].toString(),
  );
  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "product_name": productTitle,
    "user_id": userId,
    'image': productImage,
    'price': productPrice,
    'descripe': productDesc,
  };
}