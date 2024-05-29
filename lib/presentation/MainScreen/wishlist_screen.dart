import 'package:electronic_store/Models/wishlist_model.dart';
import 'package:electronic_store/Provider/provider_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/wishList_item.dart';
import 'main_screen.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final _provider=Provider.of<ModelProvider>(context);
    return Scaffold(
      body:SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder (
                // pass the list (postsFuture)
                  future: _provider.getWishListItems(),
                  builder: (context, snapshot){
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      final posts=snapshot.data! as List<WishListModel>;
                      return buildPosts(posts);
                    } else {
                      return Center(child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
              
                          Image.asset('assets/images/empty-cart.png'),
                          Text(
                            "سلة الامنيات فارغه",
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
                            text: "تصفح المنتجات ",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ));
                    }
                    return Container();
                  }
              ),
            ),
          ],
        ),
      )
    );
  }
 Widget buildPosts(List<WishListModel> posts){
    return ListView.builder(
        itemCount: posts.length,
        itemBuilder: (c,index){
        return WishListItem(model: posts[index]);
    }
    );
  }
}
