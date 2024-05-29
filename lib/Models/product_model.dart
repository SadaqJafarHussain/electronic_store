
class ProductModel{
 final int productId;
 int productCount;
 final String productTitle;
 final String productImage;
 final String productDesc;
 final String productqty;
 final double productPrice;
 final String catId;
  String iswish;

 ProductModel({
   required this.productId,
   required this.iswish,
   required this.catId,
   required this.productCount,
   required this.productDesc,
   required this.productImage,
   required this.productPrice,
   required this.productqty,
   required this.productTitle,
});
 factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
   productId:json['id'],
   catId: json['subcat_id'].toString(),
   productCount:int.parse(json['product_count'].toString()) ,
   productDesc: json['descripe'].toString(),
   productImage:  json['url_image'].toString(),
   productPrice: double.parse(json['price'].toString()),
   productqty: json['qty'].toString(),
   productTitle: json['name'].toString(),
   iswish: json['is_wish'].toString(),
 );
 Map<String, dynamic> toJson() => {
   "id": productId,
   "name": productTitle,
   "qty": productqty,
   "product_count": productCount,
   'url_image': productImage,
   'price': productPrice,
   'descripe': productDesc,
   'subcat_id': catId,
 };
}