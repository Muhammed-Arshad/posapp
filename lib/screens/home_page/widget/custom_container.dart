import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posapp/widgets/text_style.dart';

Widget customContainer(String amount, {Color color = Colors.black}) {
  return Container(
    height: 60,
    width: 300,
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
    ),
    child: Center(
      child: CustomTextWidget().customTextBL(amount, color: color),
    ),
  );
}

Widget buttonContainer(text,
    {Color textClr = Colors.black,
    Color bgClr = const Color(0xff00008b),
    required VoidCallback onTap}) {
  return InkWell(
    splashColor: Colors.green,
    // onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: MaterialButton(
        onPressed: onTap,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        elevation: 5.0,
        minWidth: 200.0,
        height: 35,
        color: bgClr,
        child:
            Center(child: CustomTextWidget().customTextMB(text, color: textClr)),
      ),
    ),
  );
}
