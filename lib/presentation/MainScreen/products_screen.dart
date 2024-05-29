import 'package:carousel_slider/carousel_slider.dart';
import 'package:electronic_store/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/provider_model.dart';
import '../../widgets/product_item.dart';
class ProductsScreen extends StatefulWidget {
  final bool slider;
  final bool moreText;
  const ProductsScreen({required this.slider,required this.moreText,super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final CarouselController _controller = CarouselController();
  int _current = 1;
  Widget _buildSliderView(BuildContext context) {
    return SizedBox(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
              enlargeFactor: 1,
              height: 160.h,
              autoPlay: true,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 10.h,
                height: 10.h,
                margin: EdgeInsets.symmetric(horizontal: 4.0),
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
  @override
  Widget build(BuildContext context) {
    final _provider =widget.slider? Provider.of<ModelProvider>(context).products:
    Provider.of<ModelProvider>(context).subProducts;
    return Scaffold(
      appBar:widget.slider?null: AppBar(
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Column(
            children: [
             widget.slider? _buildSliderView(context):Container(),
            widget.moreText?  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'وصل حديثا',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.fSize,
                        fontFamily: 'Cairo',
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      ' عرض المزيد >>',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.fSize,
                        fontFamily: 'Cairo',
                        color: Color(0xff514EB7),
                      ),
                    ),
                  ],
                ),
              ):Container(),
              Container(
                color: Colors.transparent,
                height: 800.h,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1 / 1.2,
                    crossAxisCount: 2, // number of items in each row
                    mainAxisSpacing: 8.0, // spacing between rows
                    crossAxisSpacing: 8.0,
                    // spacing between columns
                  ),
                  padding: EdgeInsets.all(8.0), // padding around the grid
                  itemCount:
                  _provider.length, // total number of items
                  itemBuilder: (context, index) {
                    return ProductItem(
                      model:_provider[index],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
final List<Widget> imageSliders = imgList
    .map((item) => Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    image: DecorationImage(
      image: AssetImage(item),
      fit: BoxFit.fill,
    ),
  ),
))
    .toList();
final List<String> imgList = [
  'assets/images/phones.jpg',
  'assets/images/cameras.jpeg',
  'assets/images/tvs.jpg',
  'assets/images/electronic.jpeg',
];
