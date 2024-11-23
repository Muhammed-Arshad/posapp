import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posapp/provider/home_provider/model/product_model.dart';
import 'package:posapp/provider/product_provider/model/all_products.dart';

import '../../../provider/home_provider/products_provider.dart';


void showQuantityDialog(BuildContext context) {
  final TextEditingController quantityController = TextEditingController();
  String selectedUnit = 'kg';

  List<String> measureList = ['g', 'kg', 'ml', 'l'];

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {

          late final Product lastProduct;

          final product = ref.watch(productProvider);
          if(product.isNotEmpty){
            lastProduct = ref.read(productProvider).last;
            quantityController.text = lastProduct.quantity.toString();
          }

          switch(product.last.productUnit){
            case ProductUnit.g:
              measureList = ['g', 'kg'];
              selectedUnit = 'g';
            case ProductUnit.kg:
              measureList = ['g', 'kg'];
              selectedUnit = 'kg';
            case ProductUnit.ml:
              measureList = ['ml', 'l'];
              selectedUnit = 'ml';
            case ProductUnit.l:
              measureList = ['ml', 'l'];
              selectedUnit = 'l';
          }

          return AlertDialog(
            title: Text("Enter Quantity"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: quantityController,
                  decoration: InputDecoration(
                    labelText: "Quantity (Kg/L)",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: (){
                          quantityController.clear();
                        },
                        icon: Icon(Icons.close))
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: selectedUnit,
                  decoration: InputDecoration(
                    labelText: "Select Unit",
                    border: OutlineInputBorder(),
                  ),
                  items: measureList.map((String unit) {
                    return DropdownMenuItem<String>(
                      value: unit,
                      child: Text(unit),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedUnit = value!;
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  // Handle the values here
                  print("Quantity: ${quantityController
                      .text}, Unit: $selectedUnit");

                  ProductUnit unit = ProductUnit.g;

                  switch(selectedUnit){
                    case 'g':
                      unit = ProductUnit.g;
                    case 'kg':
                      unit = ProductUnit.kg;
                    case 'ml':
                      unit = ProductUnit.ml;
                    case 'l':
                      unit = ProductUnit.l;
                  }

                  // lastProduct.copyWith(
                  //   productWeight: unit
                  // );

                  ref.read(productProvider.notifier).updateProductQuantity(
                    double.parse(quantityController.text),lastProduct,unit
                  );

                  Navigator.of(context).pop();
                },
                child: Text("Submit"),
              ),
            ],
          );
        });
    },
  );
}
