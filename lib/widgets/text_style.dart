import 'package:flutter/material.dart';

class CustomTextWidget{

  customTextBL(text, {Color color = Colors.black}){
    return Text(text,
        style: TextStyle(
            color:  color,
            fontWeight: FontWeight.w700,
            fontFamily: "Poppins",
            fontStyle:  FontStyle.normal,
            fontSize: 20.0
        ),
        textAlign: TextAlign.left
    );
  }

  customTextB(text,{Color color = Colors.black}){
    return Text(text,
        style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins",
            fontStyle:  FontStyle.normal,
            fontSize: 15.0
        ),
        textAlign: TextAlign.left
    );
  }

  customTextMB(text,{Color color = Colors.black}){
    return Text(text,
        style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins",
            fontStyle:  FontStyle.normal,
            fontSize: 13.0
        ),
        textAlign: TextAlign.left
    );
  }

  customTextM(text,{color = const Color(0xff072944)}){
    return Text(text,
        style:  TextStyle(
          color:  color,
          fontWeight: FontWeight.w600,
          fontFamily: "Poppins",
          fontStyle:  FontStyle.normal,
          fontSize: 10.0
        ),
        textAlign: TextAlign.left
    );
  }

  customTextMS(text){
    return Text(text,
        style: const TextStyle(
            color:  Color(0xff072944),
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins",
            fontStyle:  FontStyle.normal,
            fontSize: 10.0,
        ),
        textAlign: TextAlign.left
    );
  }

  customTextS(text){
    return Text(text,
        style: const TextStyle(
            color:  Color(0xff072944),
            fontWeight: FontWeight.w400,
            fontFamily: "Poppins",
            fontStyle:  FontStyle.normal,
            fontSize: 10.0
        ),
        textAlign: TextAlign.left
    );
  }
}