import 'package:electronic_store/core/app_export.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({
    Key? key,
    required this.onPressed,
    required this.isFill,
    required this.text,
    this.iconData
  });
 final String text;
 final IconData? iconData;
 final bool isFill;
 final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
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
