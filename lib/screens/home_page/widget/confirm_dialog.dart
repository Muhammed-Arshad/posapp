import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/text_style.dart';
import 'custom_container.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        width: 1300,
        height: 800,
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              height: 300,
              width: 300,
              child: GridView(
              physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.5
                      ),
                      children: [
                        buttonContainer('7', bgClr: Color(0xfff0f0f0), onTap: (){
              // provider.clickedButton('7');
                        }),
                        buttonContainer('8', bgClr: Color(0xfff0f0f0), onTap: (){
              // provider.clickedButton('8');
                        }),
                        buttonContainer('9', bgClr: Color(0xfff0f0f0), onTap: (){
              // provider.clickedButton('9');
                        }),
                        buttonContainer('4', bgClr: Color(0xfff0f0f0), onTap: (){
              // provider.clickedButton('4');
                        }),
                        buttonContainer('5', bgClr: Color(0xfff0f0f0), onTap: (){
              // provider.clickedButton('5');
                        }),
                        buttonContainer('6', bgClr: Color(0xfff0f0f0), onTap: (){
              // provider.clickedButton('6');
                        }),
                        buttonContainer('1', bgClr: Color(0xfff0f0f0), onTap: (){
                          // provider.clickedButton('1');
                        }),
                        buttonContainer('2', bgClr: Color(0xfff0f0f0), onTap: (){
                          // provider.clickedButton('2');
                        }),
                        buttonContainer('3', bgClr: Color(0xfff0f0f0), onTap: (){
                          // provider.clickedButton('3');
                        }),

                      ]),
            ),
            InkWell(
              onTap: (){
              },
              child: Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  border: Border.all(
                    color: Colors.white,
                    width: 2, //                   <--- border width here
                  ),
                ),
                height: 60,
                child: Center(child: CustomTextWidget().customTextB('OK',color: Colors.white)),
              ),
            )

            // Add your custom content here
          ],
        ),
      ),
    );
  }
}