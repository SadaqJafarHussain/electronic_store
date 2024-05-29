import 'package:carousel_slider/carousel_slider.dart';
import 'package:electronic_store/Provider/provider_model.dart';
import 'package:electronic_store/core/app_export.dart';
import 'package:electronic_store/presentation/MainScreen/main_screen.dart';
import 'package:electronic_store/presentation/Sign%20in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_elevated_button.dart';
import '../Sign up/sign_up.dart';

class AfterSplash extends StatefulWidget {
   AfterSplash({Key? key})
      : super(
          key: key,
        );

  @override
  State<AfterSplash> createState() => _AfterSplashState();
}

class _AfterSplashState extends State<AfterSplash> {
   final CarouselController _controller = CarouselController();

  int _current = 1;
  @override
  void initState() {
   Provider.of<ModelProvider>(context,listen: false).getCartItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _provider=Provider.of<ModelProvider>(context);
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Color(0xff514EB7),
      body: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.symmetric(
                horizontal: 27.h,
                vertical: 16.v,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 _buildSliderView(context),
                  SizedBox(height: 24.v),
                  SizedBox(height: 20.v),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomElevatedButton(
                        isFill: false,
                        onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
                        },
                        text: "تصفح المنتجات",
                      ),
                      CustomElevatedButton(
                        isFill: true,
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>SignUp()));
                        },
                        text: "تسجيل حساب جديد",
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("لديك حساب بالفعل ؟ ",
                      style: TextStyle(
                        fontFamily: 'Cairo'
                      ),),
                      TextButton(
                          onPressed: () {
                          },
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (_)=>SignIn()));
                            },
                            child: const Text("تسجيل الدخول", style: TextStyle(
                                color:Color(0xff514EB7),
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w800),),
                          )
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

   Widget _buildSliderView(BuildContext context) {
     return SizedBox(
       child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             CarouselSlider(
               items: imageSliders,
               carouselController: _controller,
               options: CarouselOptions(
                 viewportFraction: 1,
                   height: 500.h,
                   autoPlay: true,
                   enlargeCenterPage: true,
                   onPageChanged: (index, reason) {
                     setState(() {
                       _current = index;
                     });
                   }),
             ),
             SizedBox(height: 10.h,),
             FittedBox(
               child: Text(
                 "مرحبًا بك في عالم الجودة والتقنية",
                 maxLines: 2,
                 overflow: TextOverflow.ellipsis,

                 style: theme.textTheme.headlineLarge,
               ),
             ),
             SizedBox(height: 13.v),
             Text(
               "مرحبا بك في تطبيقنا للتسوق الألكتروني  حيث",
               style: theme.textTheme.titleLarge,
             ),
             SizedBox(height: 2.v),
             Text(
               "تلتقي التقنية بالجودة والرحة",
               style: theme.textTheme.titleLarge,
             ),
             SizedBox(height: 20.h,),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: imgList.asMap().entries.map((entry) {
                 return GestureDetector(
                   onTap: () => _controller.animateToPage(entry.key),
                   child: Container(
                     width: 18.h,
                     height: 18.h,
                     margin: EdgeInsets.symmetric( horizontal: 4.0),
                     decoration: BoxDecoration(
                         shape: BoxShape.circle,
                         color: (Theme.of(context).brightness == Brightness.dark
                             ? Colors.white
                             : Color(0xff514EB7))
                             .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                   ),
                 );
               }).toList(),
             ),
           ]),
     );
   }
}
final List<Widget> imageSliders = imgList
    .map((item) => ClipRRect(
  borderRadius: BorderRadius.circular(30),
      child: Image.asset(item,
      height: 400,
      fit: BoxFit.fill,),
    )
)
    .toList();
final List<String> imgList = [
  'assets/images/img_rectangle.png',
  'assets/images/img_rectangle.png',
  'assets/images/img_rectangle.png',
  'assets/images/img_rectangle.png',
];
