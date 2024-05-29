import 'package:electronic_store/Models/product_model.dart';
import 'package:electronic_store/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/provider_model.dart';
import '../../widgets/search_bar.dart';
import '../CartScreen/cart_screen.dart';
import '../Sign up/sign_up.dart';
class ItemDetails extends StatelessWidget {
  final ProductModel model;
  const ItemDetails({required this.model,super.key});

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ModelProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xff514EB7),
      body: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
          ),
          body: SizedBox(
            height: double.maxFinite,
            child: Stack(
              children: [
                Container(
                  height: 400.h,
                  width:MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                      image: NetworkImage(model.productImage),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft:Radius.circular(30))
                    ),
                    height: 400.h,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 70.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 20.0),
                              padding: EdgeInsets.only(left: 1.0,right: 1.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color(0xffD9D9D9),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      _provider.minusButton(model.productId);
                                    },
                                    child: CircleAvatar(
                                      radius: 20.h,
                                      backgroundColor: Color(0xffFFFFFF),
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8,),
                                  Text('${model.productCount}',style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.fSize
                                  ),),
                                  SizedBox(width: 8,),
                                  InkWell(
                                    onTap: (){
                                      _provider.addButton(model.productId);
                                    },
                                    child: CircleAvatar(
                                      radius: 20.h,
                                      backgroundColor: Color(0xff919191),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: CircleAvatar(
                                backgroundColor: Color(0xffCECECE),
                                child: IconButton(
                                  onPressed: () async{
                                    var userid= await _provider.getPrefsData('userId');
                                    if(userid=='0'){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                                    }else {
                                      _provider.manageWishList(model);
                                    }
                                  },
                                  icon: Icon(model.iswish=='yes'?Icons.favorite:Icons.favorite_border,color: Color(0xff514EB7),),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 50.h,),
                        Padding(
                          padding: const EdgeInsets.only(right: 20,top: 10),
                          child: Text(
                            '${model.productTitle}',
                            style: TextStyle(
                                fontSize: 22.fSize,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cairo'),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.all( 20.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${model.productDesc} هنا يكتب وصف المنتج هنا تكتب'
                                          'وصف المنتج هنا تكتب وصف المنتج',style: TextStyle(
                                        fontSize: 15.fSize,
                                        color: Colors.black,
                                        fontFamily: 'Cairo'),),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10.0,
                  left: 20.0,
                  right: 20.0,
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0,top: 5.0),
                        child: Text(
                          'IQD ${model.productPrice}',style: TextStyle(
                            fontSize: 20.fSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'Cairo'),),
                      ),
                      _customButton(
                        "اضف الى السلة",
                        Icons.shopping_cart_outlined,
                        true,
                            () async{
                              var userid= await _provider.getPrefsData('userId');
                              if(userid=='0'){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                              }else {
                                _provider.addCartProducts(model);
                              }
                        },
                      ),
                    ],

                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _customButton(String text,IconData? iconData,bool isFill,VoidCallback onPressed){
    return iconData==null?OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.pink, backgroundColor: isFill?Color(0xff514EB7):Colors.white, // <- this changes the splash color
          side: BorderSide(width: 1, color: Color(0xff514EB7)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Text(text,style:TextStyle(
            fontSize: 18.fSize,
            color: isFill?Colors.white:Color(0xff514EB7),
            fontFamily: 'Cairo')),
    ):
    OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(iconData,size: 30.h,color: isFill?Colors.white:Color(0xff514EB7),),
      label:Text(text,style:TextStyle(
          fontSize: 15.fSize,
          color: isFill?Colors.white:Color(0xff514EB7),
          fontFamily: 'Cairo')),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.pink, backgroundColor: isFill?Color(0xff514EB7):Colors.white, // <- this changes the splash color
        side: BorderSide(width: 1, color: Color(0xff514EB7)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
