import 'package:electronic_store/Models/category_model.dart';
import 'package:electronic_store/core/app_export.dart';
import 'package:electronic_store/presentation/MainScreen/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/provider_model.dart';

class SubCategoryScreen extends StatelessWidget {
 final CategoryModel categoryModel;
  const SubCategoryScreen({required this.categoryModel,super.key});

  @override
  Widget build(BuildContext context) {
    final _provider=Provider.of<ModelProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryModel.name,
          style: TextStyle(
            color: Colors.black87,
            fontFamily: 'Cairo',
            fontSize: 20.h,
          ),),
      ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1 / 1.2,
              crossAxisCount: 3, // number of items in each row
              mainAxisSpacing: 4.0, // spacing between rows
              crossAxisSpacing: 1.0,
              // spacing between columns
            ),
            itemCount: _provider.subCategories.length,
            itemBuilder: (context,index){
              return InkWell(
                onTap: ()async{
                  await _provider.getSubProducts(_provider.subCategories[index].id);
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductsScreen(slider: false, moreText: false)));
                },
                child: Column(
                  children: [
                    Text(_provider.subCategories[index].name,overflow: TextOverflow.ellipsis, style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),),
                    const SizedBox(height: 10,),
                    Container(
                      height: 80,
                      padding: EdgeInsets.all(15),
                      width: 80,
                      decoration: BoxDecoration(
                          border: Border.all(color:Color(0xff514EB7),width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        image: DecorationImage(
                          image: NetworkImage(_provider.subCategories[index].image),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
        ),
    );
  }
}
