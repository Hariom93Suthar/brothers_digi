import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UiHelper {
  static Widget color(String name, Color color1, Color color2, Color color3, Color color4) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [color1, color2, color3,color4],
        tileMode: TileMode.clamp, // Add this to ensure gradient coverage
        begin: Alignment.topCenter, // Adjust gradient direction if needed
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        name,
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: "Ubuntu-Regular"
          // This color is used as a fallback
        ),
      ),
    );
  }
  static container(String img, final width){
    return Card(
      color: Colors.transparent,
      shadowColor: Colors.indigo,
      elevation: 10,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(img),
        ),
      ),
    );
  }
  static button(final width,final path){
    return InkWell(
      onTap: (){
        Get.to(path);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Container(
          height: 60,
          width: width,
          decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.circular(20)
          ),
          child: Center(
            child: Text("View More",style: TextStyle(
                fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),),
          ),
        ),
      ),
    );}
  static listtile(String txt, final icon){
    return ListTile(
      leading: Icon(icon,size: 30,color: Colors.black,),
      title: Text(txt,style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w400),),
    );
  }
  static roundcontainer(String img){
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(img)
          ),
          color: Color(0xFF003399),
          borderRadius: BorderRadius.circular(10)
      ),
    );
  }
  static Minfo(String img,String txt){
    return Row(
      children: [
        Container(
          height: 90,width: 90,
          decoration: BoxDecoration(
            //color: Colors.indigo,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
              image: DecorationImage(
                image: AssetImage(img),
              )
          ),
        ),
        SizedBox(width: 40,),
        Text.rich(TextSpan(
            text: txt,
            style: TextStyle(fontSize:30,fontWeight: FontWeight.bold)
        ))
      ],
    );
  }
}
