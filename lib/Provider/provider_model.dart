 import 'dart:async';
import 'dart:convert';
import 'package:electronic_store/Models/category_model.dart';
import 'package:electronic_store/Models/product_model.dart';
import 'package:electronic_store/Models/user_model.dart';
import 'package:electronic_store/Models/wishlist_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 import 'package:http/http.dart'as http;
 import 'package:shared_preferences/shared_preferences.dart';
import '../Models/cart_model.dart';

class ModelProvider extends ChangeNotifier{
  String errorMessage='';
  String token='eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ';
  String messageNotification='';
  String signUpMessage='';
  List<ProductModel> subProducts=[];
  List< CategoryModel> subCategories=[];
  UserModel userModel=UserModel(email: '', image: '', name: '');
  int statusCode=0;
  int? userId=0;
  List<CategoryModel> categories=[];
  List<ProductModel> products=[];
  late UserModel userInfo;
  String baseUrl='https://id-form.info/alictrone/apis/';

  Future setPrefsData(int value) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('userId', value);
  }

  Future getPrefsData(String key) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   int? data= await prefs.getInt(key);
   userId=data;
   notifyListeners();
  }
getSubProducts(int id)async{
  List<ProductModel> _localCat=[];
  String url='${baseUrl}product/read_by_cat.php?token=$token&subcat_id=$id';
    final response=await http.get(Uri.parse(url));
    var responseDate=json.decode(response.body);
    print(responseDate);
    if(responseDate['code']==400||responseDate['code']==401||responseDate['code']==402){
      errorMessage=responseDate['message'];
    }else{
      for (Map<String,dynamic> item in responseDate['message']) {
        print(item);
        _localCat.add(ProductModel.fromJson(item));
      }
      print(_localCat);
      subProducts=_localCat;
}
    notifyListeners();
  }
  getSubCategories(int id)async{
    String url='${baseUrl}category/sub_category_by_cat_id.php?token=$token&cat_id=$id';
    List<CategoryModel> _localCat=[];
    final response=await http.get(Uri.parse(url));
    var responseDate=json.decode(response.body);
    print(responseDate);
    if(responseDate['code']==400||responseDate['code']==401||responseDate['code']==402){
      errorMessage=responseDate['message'];
    }
    else{
      for (Map<String,dynamic> item in responseDate['message']) {
        print(item);
        _localCat.add(CategoryModel.fromJson(item));
      }
      print(_localCat);
      subCategories=_localCat;
    }
    notifyListeners();
  }

  getCategory()async{
    String url='${baseUrl}/category.php?token=$token';
    List<CategoryModel> _localCat=[];
    final response=await http.get(Uri.parse(url));
    var responseDate=json.decode(response.body);
    for (Map<String,dynamic> item in responseDate['message']) {
     _localCat.add(CategoryModel.fromJson(item));
    }
    categories=_localCat;
    notifyListeners();
  }

  Future getProducts()async{
    List<ProductModel> _localProducts=[];
    String url = "${baseUrl}product/new_arive.php?token=$token";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);
      for (Map<String,dynamic> item in responseData['message']) {
        _localProducts.add(ProductModel.fromJson(item));
      }
      products=_localProducts;
    notifyListeners();
  }


  manageWishList (ProductModel model){
    if(model.iswish=='yes'){
      deleteWishListItem(model.productId,10);
      model.iswish='no';
    }else{
      sendWishListItem(model);
      model.iswish='yes';
    }
    notifyListeners();
  }

 Future<List<CartModel>> getCartItems()async{
    List<CartModel> _localCart=[];
    String url = "${baseUrl}"
        "cart/cart.php?token=eyJzdWIiOiIxMjM0NTY3ODkwIiw"
        "ibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ&"
        "status=padding&user_id=$userId";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);
    if(responseData['message']!=null){
    for (Map<String,dynamic> item in responseData['message']) {
        _localCart.add(CartModel.fromJson(item));
    }
    }
    return _localCart;
  }

  Future<List<WishListModel>> getWishListItems()async{
    String url = "${baseUrl}wishlist/get_wishlist."
        "php?token=$token&user_id=$userId";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);
    final List body=responseData['message'];
    return body.map((e)=>WishListModel.fromJson(e)).toList();
  }

 Future addCartProducts (ProductModel model) async{
    var response= await http.post(Uri.parse('${baseUrl}cart/add.php?token=$token'),
        body: {
      'product_id':model.productId.toString(),
          'user_id':userId.toString(),
          'price':model.productPrice.toString(),
          'qty':model.productqty.toString()
    });
    print(response.body);
    notifyListeners();
  }


  emptyCart () async{
    var response = await http.post(Uri.parse('${baseUrl}cart/delete.php?token=$token'),
        body: {
          'id':0.toString(),
          "user_id":userId,
          'type':'all',
        });
    print(response.statusCode);
    print(response.headers);
    print(response.body);
    notifyListeners();
  }
  deleteCartItem(CartModel model) async{
    var response = await http.post(Uri.parse('${baseUrl}cart/delete.php?token=$token'),
        body: {
          "id":model.id.toString(),
          "user_id":userId,
          'type':'one',
        });
    print(response.statusCode);
    print(response.headers);
    print(response.body);
    notifyListeners();
  }
 Future<void> sendWishListItem(ProductModel model) async{
   var response = await http.post(Uri.parse('${baseUrl}wishlist/add.php?token=$token'),
       body: {
         'product_id':model.productId.toString(),
         'user_id':userId,

       });
       print(response.statusCode);
       print(response.body);
  }
  
  Future signUpMethod(String email,String userName,String password)async{
    var response =await http.post(Uri.parse('${baseUrl}users/register.php?token=$token'),
    body: {
      'name':userName,
      'email':email,
      'password':password
    });
    print(response.statusCode);
    print(response.body);
    Map<String,dynamic> responseData=jsonDecode(response.body);
    var data=responseData['message'];
    setPrefsData(data[0]['id']);
    statusCode=int.parse(responseData['code']);
  }

 getUserInfo()async{
    var response=await http.get(Uri.parse('${baseUrl}users/user_by_id.php?token=$token&user_id=$userId'));
    print(response.body);
    userModel= UserModel.fromJso(jsonDecode(response.body));
    notifyListeners();
  }

  Future logInMethod(String email,String password)async{
    var response =await http.get(Uri.parse('${baseUrl}users/login.php?token=$token&email=$email&password=$password'),
       );
    Map<String,dynamic> responseData=jsonDecode(response.body);
    var data=responseData['message'];
    statusCode=int.parse(responseData['code']);
    print(response.body);
   await setPrefsData(data[0]['id']);
  }
  Future deleteWishListItem(int id,int userId) async{
     products.where((element) => element.productId==id).first.iswish='no';
    var response = await http.post(Uri.parse('${baseUrl}wishlist/delete.php?token=$token'),
        body: {
          "id":id.toString(),
          "user_id":userId,
        });
    print(response.body);
    Map<String,dynamic> data=jsonDecode(response.body);
    print(data['code']);

    notifyListeners();
  }


  addButton(int id)async{

  }
  minusButton(int id){
  }
}