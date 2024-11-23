import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posapp/provider/product_provider/model/all_products.dart';

import '../../provider/home_provider/model/product_model.dart';
import '../../provider/product_provider/all_products_provider.dart';

class ProductTableView extends ConsumerWidget {
  const ProductTableView({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    List<AllProduct> products = ref.watch(allProductProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Product Table'),
            SizedBox(
              width: 750,
              height: 500,
              child: DataTable2(
                  columnSpacing: 12,
                  horizontalMargin: 12,
                  minWidth: 600,
                  columns: const [
                    // DataColumn2(
                    //   label: Text('Column A'),
                    //   size: ColumnSize.L,
                    // ),
                    DataColumn(label: Text('SI No')),
                    DataColumn(label: Text('Product Code')),
                    DataColumn(label: Text('Product Name')),
                    DataColumn(label: Text('Quantity(kg/L)')),
                    DataColumn(label: Text('Price')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: products.map(
                          (data) => DataRow(
                            color: data.productType == ProductType.veg ?
                            WidgetStateProperty.all<Color>(Colors.blue.shade100)
                                :WidgetStateProperty.all<Color>(Colors.red.shade100),
                              cells: [
                        DataCell(Text(data.no.toString())),
                        DataCell(Text(data.productCode)),
                        DataCell(Text(data.productName)),
                        DataCell(Text(data.quantity.toString())),
                        DataCell(Text(data.price.toString())),
                                DataCell(Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blueAccent,
                                    ),
                                    child: Center(
                                      child: IconButton(
                                        icon: Icon(Icons.edit,color: Colors.white,),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                )),
                      ])).toList()),
            ),
          ],
        ),
      ),
    );
  }
}