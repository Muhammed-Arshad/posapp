import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posapp/widgets/text_style.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final double height;
  final double width;
  final Color btnColor;
  final Color textColor;
  final String btnText;
  const ButtonWidget({super.key,
    required this.onTap,
    this.height = 60,
    this.width = 150,
    this.btnColor = Colors.teal,
    this.textColor = Colors.white,
    required this.btnText});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
          border: Border.all(
            color: Colors.white,
            width: 2, //                   <--- border width here
          ),
        ),
        height: height,
        child: Center(child: CustomTextWidget().
          customTextB(btnText,color: textColor)),
      ),
    );
  }
}
