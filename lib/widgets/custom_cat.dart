
import 'package:electronic_store/core/app_export.dart';
import 'package:flutter/material.dart';
class CustomCartButton extends StatelessWidget {
  final String name;
  final IconData iconData;
  final VoidCallback fumction;
  const CustomCartButton({required this.iconData,required this.name,required this.fumction,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xff514EB7),
          ),
          child: IconButton(
            onPressed: fumction,
            icon: Icon(iconData,
              color: Colors.white,
            size: 18,),
          ),
        ),
        Text('$name',style: TextStyle(
          fontSize: 20.fSize,
          fontFamily: 'Cairo',
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),)
      ],
    );
  }
}
