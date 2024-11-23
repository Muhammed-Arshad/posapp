import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posapp/screens/home/widget/quantity_dialogbox.dart';
import 'package:posapp/screens/sales/sales_view.dart';

import '../../../provider/home_provider/products_provider.dart';
import 'custom_container.dart';

class NumberSwitchWidget extends ConsumerWidget {
  final TextEditingController barcodeText;
  const NumberSwitchWidget(this.barcodeText, {super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {


    return GridView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1.5
      ),
      children: [
        buttonContainer('PRINT', textClr: Colors.white, onTap: (){
        }),
        buttonContainer('SUBTOTAL', textClr:Colors.white, onTap: (){
          Navigator.push(context, MaterialPageRoute(builder:
              (BuildContext context) => SalesView()));
        }),
        buttonContainer('REFUND', textClr:Colors.white, onTap: (){}),
        buttonContainer('EXIT', textClr: Colors.white, onTap: (){}),

        buttonContainer('7', bgClr: Color(0xfff0f0f0), onTap: (){
          ref.read(productProvider.notifier).clicked('7',barcodeText);
          // ctrl.text = num;
        }),
        buttonContainer('8', bgClr: Color(0xfff0f0f0), onTap: (){
          ref.read(productProvider.notifier).clicked('8',barcodeText);
        }),
        buttonContainer('9', bgClr: Color(0xfff0f0f0), onTap: (){
          ref.read(productProvider.notifier).clicked('9',barcodeText);
        }),
        buttonContainer('QTY', textClr: Colors.white,bgClr: Color(0xff0000ff), onTap: (){
          if(ref.read(productProvider).isNotEmpty){
            showQuantityDialog(context);
          }
        }),

        buttonContainer('4', bgClr: Color(0xfff0f0f0), onTap: (){
          ref.read(productProvider.notifier).clicked('4',barcodeText);
        }),
        buttonContainer('5', bgClr: Color(0xfff0f0f0), onTap: (){
          ref.read(productProvider.notifier).clicked('5',barcodeText);
        }),
        buttonContainer('6', bgClr: Color(0xfff0f0f0), onTap: (){
          ref.read(productProvider.notifier).clicked('6',barcodeText);
        }),
        buttonContainer('CLEAR', textClr: Colors.white,bgClr: Colors.red, onTap: (){
          // provider.activeCtrl.clear();
          barcodeText.clear();
        }),

        buttonContainer('1', bgClr: Color(0xfff0f0f0), onTap: (){
          ref.read(productProvider.notifier).clicked('1',barcodeText);
        }),
        buttonContainer('2', bgClr: Color(0xfff0f0f0), onTap: (){
          ref.read(productProvider.notifier).clicked('2',barcodeText);
        }),
        buttonContainer('3', bgClr: Color(0xfff0f0f0), onTap: (){
          ref.read(productProvider.notifier).clicked('3',barcodeText);
        }),
        buttonContainer('CASH', textClr: Colors.white,bgClr: Colors.green, onTap: (){
          // ref.read(productProvider.notifier).clicked('2',barcodeText);
        }),

        buttonContainer('0', bgClr: Color(0xfff0f0f0), onTap: (){
          ref.read(productProvider.notifier).clicked('0',barcodeText);
        }),
        buttonContainer('.', bgClr: Color(0xfff0f0f0), onTap: (){
          ref.read(productProvider.notifier).clicked('.',barcodeText);
        }),
        buttonContainer('00', bgClr: Color(0xfff0f0f0), onTap: (){
          ref.read(productProvider.notifier).clicked('00',barcodeText);
        }),
        buttonContainer('CARD', textClr: Colors.white, onTap: (){}),
      ],
    );
  }
}
