import 'package:electronic_store/Models/product_model.dart';
import 'package:electronic_store/core/app_export.dart';
import 'package:electronic_store/presentation/MainScreen/main_screen.dart';
import 'package:electronic_store/widgets/cartItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/cart_model.dart';
import '../../Provider/provider_model.dart';
import '../../widgets/custom_elevated_button.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
TextEditingController name=TextEditingController();
TextEditingController address=TextEditingController();
TextEditingController phone=TextEditingController();

  @override
  void initState() {
    Provider.of<ModelProvider>(context,listen: false).getCartItems();
    super.initState();
  }
  Widget showSheet(){
    return Container(
      height: 500,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(' رقم هاتف الزبون :',style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                  color: Colors.black54
                ),),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 400,
                  child: Form(
                    child: TextFormField(
                      style: TextStyle(
                          height: 1,
                          fontSize: 13,
                          fontFamily: 'Cairo'
                      ),
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: phone,
                      decoration: InputDecoration(
                          hintText: "078xxxxxxx",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide(
                                  color:Colors.grey)
                          ),
                          fillColor: Color(0xffF5F5F5),
                          filled: true,
                          prefixIcon: const Icon(Icons.person)),
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                ),

              ],),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(' عنوان السكن :',style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                    color: Colors.black54
                  ),),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 400,
                    child: Form(
                      child: TextFormField(
                        style: TextStyle(
                            height: 1,
                            fontSize: 12
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: address,
                        decoration: InputDecoration(
                            hintText: "ذي قار_ سوق الشيوخ _ كرمة بني سعيد",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide(
                                    color: Colors.grey
                                )
                            ),
                            fillColor: Color(0xffF5F5F5),
                            filled: true,
                            prefixIcon: const Icon(Icons.home)),
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomElevatedButton(
                  isFill: false,
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  text: "الغاء",
                ),
                const SizedBox(
                  width: 15,
                ),
                CustomElevatedButton(
                  isFill: true,
                  onPressed: (){
                  },
                  text: "شراء",
                ),
              ],
            ),
          ],
      ),
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _provider=Provider.of<ModelProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xff514EB7),
      body: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            elevation: 0.0,
            backgroundColor: Colors.white,
            title: Text('سلة التسوق',
            style: TextStyle(
              color: Colors.black87,
              fontFamily: 'Cairo',
              fontSize: 20.h,
            ),),
            actions: [
              IconButton(
                onPressed: (){
                _provider.emptyCart();
              }, icon: Icon(Icons.delete_outline,color: Colors.deepOrange,size: 35.h,),),
            ],
          ),
          body: FutureBuilder<List<CartModel>>(future: _provider.getCartItems(), builder: (ctx,snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }else if(snapshot.data!.isNotEmpty){
              List<CartModel> carts=snapshot.data!;
              return buildCarts(carts);
            }else {
              return Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 20,
                  ),

                  Image.asset('assets/images/empty-cart.png'),
                  Text(
                    "السله فارغه",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo'),
                  ),
                  Text("يبدو انك لم تقم باضفة اي منتج للسله",style: TextStyle(
                      fontFamily: 'Cairo'
                  ),),
                  CustomElevatedButton(
                    isFill: true,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>MainScreen()));
                    },
                    text: "تسوق الان ",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ));
            }
          }),
        ),
      ),
    );
  }
  Widget buildCarts (List<CartModel> carts){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: carts.length,
              itemBuilder: (BuildContext context,index){
                return CartItem(
                  model: carts[index],
                  index: index,);
              }),
        ),
        CustomElevatedButton(
          isFill: true,
          onPressed: (){
            showModalBottomSheet<void>(
              context: context,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))
              ),
              backgroundColor: Colors.white,
              builder: (BuildContext context) {
                return showSheet();
              },
            );
          },
          text: "اتمام عملية الشراء",
        ),
      ],
    );
  }
}
