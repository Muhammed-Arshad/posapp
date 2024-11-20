import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posapp/provider/home_provider/price_provider.dart';

import '../../../provider/home_provider/model/product_model.dart';
import '../../../provider/home_provider/products_provider.dart';
import '../../../provider/product_provider/model/all_products.dart';
import '../home_page.dart';

class ProductTableWidget extends ConsumerWidget {
  const ProductTableWidget({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    var h = MediaQuery.sizeOf(context).height;
    var w = MediaQuery.sizeOf(context).width;

    List<Product> product = ref.watch(productProvider);

    ref.listen<List<Product>>(productProvider, (_, __) {
      ref.read(priceProvider.notifier).updateNetAmount();
    });

    // ref.listen<String>(
    //     productProvider.select((Li) => product.),
    //         (String? previousName, String newName) {
    //       print('The user name changed $newName');
    //     }
    // );

    return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              // border: Border(
              //   right: BorderSide(width: 2.0, color: Colors.lightBlue.shade600),
              // ),
              border: Border.all(width: 1.0, color: Colors.grey.shade600),
            ),
            height: h/2,
            width: w*0.6,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FittedBox(
                    child: DataTable(
                      columns: [
                        DataColumn(label: text.customTextB('SI No')),
                        DataColumn(label: text.customTextB('Item Code')),
                        DataColumn(label: text.customTextB('Item Name')),
                        DataColumn(label: text.customTextB('Quantity')),
                        DataColumn(label: text.customTextB('Price')),
                        DataColumn(label: text.customTextB('Total Price')),
                        DataColumn(label: text.customTextB('Actions')),
                      ],
                      rows: product.map(
                            (data) => DataRow(
                            color:
                            data.productType == ProductType.veg?
                            WidgetStateProperty.all<Color>(Colors.green.shade100):
                            WidgetStateProperty.all<Color>(Colors.orange.shade100),
                            cells: [
                              DataCell(text.customTextB((product.indexOf(data) + 1).toString())),
                              // DataCell(text.customTextB(data.no.toString())),
                              DataCell(text.customTextB(data.itemCode)),
                              DataCell(text.customTextB(data.itemName.toString().toUpperCase())),
                              DataCell(text.customTextB(data.quantity.toString())),
                              DataCell(text.customTextB((data.amount).toString())),
                              DataCell(text.customTextB((data.amount * data.quantity).toString())),
                              DataCell(Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Container(
                                      // height: 40,
                                      // width: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.blueAccent,
                                      ),
                                      child: Center(
                                        child: IconButton(
                                          icon: Icon(Icons.add,color: Colors.white,),
                                          onPressed: () {
                                            // setState(() {

                                            // data.quantity ++;

                                            // });

                                            ref.read(productProvider.notifier).addProductCount(data);

                                            // ---- provider.getPriceTotal(provider.tableData);

                                            // provider.totalAmount[0].subTotal = '100';

                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {

                                      // if(data['Quantity'] <= 1){
                                      //   return;
                                      // }

                                      ref.read(productProvider.notifier).removeProductCount(data);

                                      // data['Quantity']--;

                                      //---- provider.getPriceTotal(provider.tableData);
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.red,
                                      ),

                                      child: Center(
                                        child: IconButton(
                                          icon: const Icon(Icons.close),
                                          onPressed: () {

                                            ref.read(productProvider.notifier).remove(data);
                                            //--- provider.tableData.remove(data);
                                            //----   provider.getPriceTotal(provider.tableData);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              )),
                            ]),
                      )
                          .toList(),
                    ),
                  ),

                ],
              ),
            )
        );
  }
}
