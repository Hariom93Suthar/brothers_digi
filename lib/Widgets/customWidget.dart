import 'package:flutter/cupertino.dart';

class CustomButtonWidget{
  static Widget button(BuildContext context,String txt,Color color,Color txtcolor){
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width*.80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Center(
        child: Text(txt,style: TextStyle(
          color: txtcolor,
          fontSize: 20,
          fontWeight: FontWeight.w700
        ),),
      ),
    );
  }

  static Widget button1(BuildContext context,String txt,Color color,Color txtcolor){
    return Container(
      height: 46,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12)
      ),
      child: Center(
        child: Text(txt,style: TextStyle(
            color: txtcolor,
            fontSize: 20,
            fontWeight: FontWeight.w500
        ),),
      ),
    );
  }
}