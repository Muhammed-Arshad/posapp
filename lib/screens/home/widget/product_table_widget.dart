import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posapp/provider/provider.dart';
import 'package:posapp/widgets/widget.dart';

class ProductTableWidget extends ConsumerWidget {
  ProductTableWidget({super.key});

  final text = CustomTextWidget();

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
                        DataColumn(label: text.customTextB('Quantity(Kg/L)')),
                        DataColumn(label: text.customTextB('Price')),
                        DataColumn(label: text.customTextB('Total Price')),
                        DataColumn(label: text.customTextB('Actions')),
                      ],
                      rows: product.map(
                            (data) => DataRow(
                            color: data.productType == ProductType.veg?
                            WidgetStateProperty.all<Color>(Colors.green.shade100):
                            WidgetStateProperty.all<Color>(Colors.orange.shade100),
                            cells: [
                              DataCell(text.customTextB((product.indexOf(data) + 1).toString())),
                              DataCell(text.customTextB(data.productCode)),
                              DataCell(text.customTextB(data.productName.toString().toUpperCase())),
                              DataCell(text.customTextB("${data.quantity.toString()} ${
                                  ref.read(productProvider.notifier).getQuantityUnit(data)
                              }")),
                              DataCell(text.customTextB("${(data.price).toString()} "
                                  "${ref.read(productProvider.notifier).getFixedUnit(data)}")),
                              DataCell(text.customTextB((data.totalAmount).toString())),
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

                                            ref.read(productProvider.notifier).addProductCount(data);

                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {

                                      ref.read(productProvider.notifier).removeProductCount(data);

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
