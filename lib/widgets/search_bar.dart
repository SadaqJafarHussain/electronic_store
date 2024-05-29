
import 'package:electronic_store/core/app_export.dart';
import 'package:electronic_store/widgets/search_item.dart';
import 'package:flutter/material.dart';

import '../Models/product_model.dart';
import 'cartItem.dart';

class CustomSearchBar extends SearchDelegate{
  final List<ProductModel> products;
  CustomSearchBar({
    required this.products,
});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: (){
      query='';
    }, icon: Icon(Icons.close,color: Colors.black87,))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      Navigator.pop(context);
    }, icon:
    Icon(Icons.arrow_back,color: Colors.black87,));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(child: Text('المنتجات'));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<ProductModel> filter=products.where((element) => element.productTitle.contains(query)).toList();
    return  ListView.builder(
        itemCount:query==''? products.length:filter.length,
        itemBuilder: (BuildContext context,index){
          return SearchItem(index: index, model:query==''?products[index]:filter[index]);
        });
  }
}