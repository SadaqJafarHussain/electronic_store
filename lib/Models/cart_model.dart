import 'package:electronic_store/Models/product_model.dart';

class CartModel{
  final int id;
  final int productId;
  final String productTitle;
  final String productImage;
   int qty;
   int count;
   double price;
  final String date;
  final String status;

  CartModel({
    required this.id,
    required this.productId,
    required this.productTitle,
    required this.productImage,
    required this.price,
    required this.qty,
    required this.date,
    required this.status,
    required this.count,
  });


  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    productId:json['product_id'],
    qty:int.parse(json['qty'].toString()) ,
    productImage:  json['image'].toString(),
    price: double.parse(json['price'].toString()),
    productTitle: json['product_name'].toString(),
    date: json['date'].toString(),
    status: json['status'].toString(),
    count: json['count'],
    id: json['id'],
  );
  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "product_name": productTitle,
    "qty": qty,
    'image': productImage,
    'price': price,
  };
}