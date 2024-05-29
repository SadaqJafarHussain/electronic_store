import 'package:electronic_store/Models/cart_model.dart';
import 'package:electronic_store/core/app_export.dart';
import 'package:electronic_store/presentation/CartScreen/cart_screen.dart';
import 'package:electronic_store/presentation/MainScreen/drawer_screen.dart';
import 'package:electronic_store/presentation/MainScreen/products_screen.dart';
import 'package:electronic_store/presentation/MainScreen/wishlist_screen.dart';
import 'package:electronic_store/presentation/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../Provider/provider_model.dart';
import '../../widgets/search_bar.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}
class _MainScreenState extends State<MainScreen> {
  String title='الصفحه الرئيسية';
  @override
  void initState() {
    Provider.of<ModelProvider>(context,listen: false).getUserInfo();
    Provider.of<ModelProvider>(context,listen: false).getCategory();

    super.initState();
  }
  List<String> titles=[
    'الصفحه الرئيسية',
    'التصنيفات',
    'الطلبات المكتمله',
    'سلة الأمنيات',
  ];
  int _currentIndex=0;
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ModelProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          drawer: DrawerScreen(userModel:_provider.userModel),
          backgroundColor: Color(0xffFFFFFF),
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            title: Text(titles[_currentIndex],
              style: TextStyle(
                color: Colors.black87,
                fontFamily: 'Cairo',
                fontSize: 20.h,
              ),),
            actions: [
              IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: CustomSearchBar(products: _provider.products));
                },
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 40.v,
                ),
              ),
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CartScreen()));
                      },
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.black,
                        size: 35.v,
                      )),
                  Positioned(
                    top: 2.0,
                    left: 4.0,
                    child: FutureBuilder<List<CartModel>> (
                      future: _provider.getCartItems(),
                      builder: (ctx,snapshot){
                        if(snapshot.connectionState==ConnectionState.waiting){
                          return Center(
                            child:  CircularProgressIndicator(),
                          );
                        }
                        else if(snapshot.data!.isNotEmpty){
                       List<CartModel> models=snapshot.data!;
                       return notTag(models);
                        }
                       else{
                         return Container();
                       }
                      },
                    )
                  )
                ],
              ),
            ],
          ),
          body: screens[_currentIndex],
          bottomNavigationBar: SalomonBottomBar(
            currentIndex: _currentIndex,
            onTap: (i)=>setState(()=>_currentIndex=i),
            items: [
              SalomonBottomBarItem(
                icon: FaIcon(FontAwesomeIcons.house),
                title: Text("الرئيسية",style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14.fSize,
                  fontWeight: FontWeight.bold,
                ),),
                selectedColor:Color(0xff514EB7),
              ),
              SalomonBottomBarItem(
                icon: FaIcon(FontAwesomeIcons.layerGroup),
                title: Text("التصنيفات",style: TextStyle(
                    fontFamily: 'Cairo',
                  fontSize: 14.fSize,
                  fontWeight: FontWeight.bold,
                ),),
                selectedColor:Color(0xff514EB7),
              ),
              SalomonBottomBarItem(
                icon: FaIcon(FontAwesomeIcons.truckFast),
                title: Text("الطلبيات",style: TextStyle(
                    fontFamily: 'Cairo',
                  fontSize: 14.fSize,
                  fontWeight: FontWeight.bold,
                ),),
                selectedColor:Color(0xff514EB7),
              ),
              SalomonBottomBarItem(
                icon: FaIcon(FontAwesomeIcons.heart),
                title: Text("قائمة الامنيات",style: TextStyle(
                    fontFamily: 'Cairo',
                  fontSize: 14.fSize,
                  fontWeight: FontWeight.bold,
                ),),
                selectedColor:Color(0xff514EB7),
              ),
            ],
          ),
        ),
      ),

    );
  }

 Widget notTag(List<CartModel> models){
    return   CircleAvatar(
      backgroundColor: Color(0xff514EB7),
      radius: 12.v,
      child: FittedBox(
        child: Text(
          '${models.first.count}',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
  List<dynamic> screens=[
    ProductsScreen(slider: true,moreText: true,),
    CategoryScreen(),
    Container(),
   WishListScreen(),
  ];

}
