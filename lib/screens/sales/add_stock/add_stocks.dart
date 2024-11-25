import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posapp/provider/product_provider/all_products_provider.dart';
import 'package:posapp/provider/product_provider/model/all_products.dart';
import 'package:posapp/screens/sales/add_stock/widget/labelled_textfield.dart';

import '../../home/widget/custom_container.dart';


class AddStocks extends StatelessWidget {
  AddStocks({super.key});

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController codeCtrl = TextEditingController();
  final TextEditingController quantityCtrl = TextEditingController();
  final TextEditingController priceCtrl = TextEditingController();
  // final TextEditingController nameCtrl = TextEditingController();
  // final TextEditingController nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          height: MediaQuery.sizeOf(context).height,
          // color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0,top: 20),
                child: SizedBox(
                  width: 500,
                  child: Column(
                    children: [
                      LabeledTextField(label: 'Product Code', ctrl: codeCtrl),
                      LabeledTextField(label: 'Product Name', ctrl: nameCtrl),
                      LabeledTextField(label: 'Quantity', ctrl: quantityCtrl),
                      // LabeledTextField(label: 'Unit', ctrl: nameCtrl),
                      LabeledTextField(label: 'Price', ctrl: priceCtrl),
                      // LabeledTextField(label: 'Type', ctrl: nameCtrl),
                      Consumer(
                        builder: (BuildContext context, WidgetRef ref, Widget? child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              buttonContainer(
                                  height: 60,
                                  'ADD STOCK', textClr: Colors.white, onTap: (){

                                    final stockLength = ref.read(allProductProvider).length;

                                    final product = AllProduct(
                                        no: stockLength + 1,
                                        productCode: codeCtrl.text,
                                        productName: nameCtrl.text,
                                        quantity: double.parse(quantityCtrl.text),
                                        price: double.parse(priceCtrl.text));

                                ref.read(allProductProvider.notifier).addToStock(product,context);
                              }),
                            ],
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
