import 'package:electronic_store/presentation/MainScreen/products_screen.dart';
import 'package:electronic_store/presentation/sub_category_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/provider_model.dart';
class CategoryScreen extends StatelessWidget {
  const CategoryScreen({ super.key});

  @override
  Widget build(BuildContext context) {
    final _provider=Provider.of<ModelProvider>(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          const SizedBox(height: 10,),
          Expanded(
            child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1 / 1.2,
                  crossAxisCount: 3, // number of items in each row
                  mainAxisSpacing: 4.0, // spacing between rows
                  crossAxisSpacing: 1.0,
                  // spacing between columns
                ),
                itemCount: _provider.categories.length,
                itemBuilder: (context,index){
                  return InkWell(
                    onTap: ()async{
                      await _provider.getSubCategories(_provider.categories[index].id);
                      var data=await _provider.getPrefsData('userId');
                      print(data);
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>SubCategoryScreen(categoryModel: _provider.categories[index],)));
                    },
                    child: Column(
                      children: [
                        Text(_provider.categories[index].name,overflow: TextOverflow.ellipsis, style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),),
                        const SizedBox(height: 10,),
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(_provider.categories[index].image),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

}
