import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:posapp/provider/product_provider/model/all_products.dart';

import '../../../constants/sized_box.dart';
import '../../../provider/product_provider/all_products_provider.dart';


class StocksView extends ConsumerWidget {
  const StocksView({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    List<AllProduct> products = ref.watch(allProductProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text('Stocks Table'),
              Expanded(
                child: SingleChildScrollView(
                  child: PaginatedDataTable(
                    columnSpacing: 30,
                    header: Text('Stocks'),
                    rowsPerPage: 10,
                    columns: const [
                      DataColumn(label: Text('SI No')),
                      DataColumn(label: Text('Product Code')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Quantity')),
                      DataColumn(label: Text('Price')),
                      // DataColumn(label: Text('Total Amount')),
                      DataColumn(label: Text('Date Added')),
                      DataColumn(label: Text('Time Added')),
                      DataColumn(label: Text('Action')),
                    ],
                    source: StockDataSource(products,ref,context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StockDataSource extends DataTableSource {
  BuildContext context;
  WidgetRef ref;
  final List<AllProduct> products;

  StockDataSource(this.products,this.ref,this.context);

  @override
  DataRow? getRow(int index) {
    if (index >= products.length) return null;

    // final sortedProducts = products
    //     .where((p) => p.dateTime != null) // Ensure dateTime is not null
    //     .toList()
    //   ..sort((a, b) => a.dateTime!.compareTo(b.dateTime!));
    //
    // final product = sortedProducts[index];
    final product = products[index];

    return DataRow(cells: [
      DataCell(Text((index + 1).toString())),
      DataCell(Text(product.productCode)),
      DataCell(Text(product.productName)),
      DataCell(Text(product.quantity.toString())),
      DataCell(Text(product.price.toString())),
      DataCell(Text(product.dateTime == null
          ? ''
          : product.dateTime!.toLocal().toString().split(' ')[0])),
      DataCell(Text(product.dateTime == null
          ? '':
          DateFormat('HH:mm:ss').format(product.dateTime!).toString())),
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
                  icon: Icon(Icons.edit,color: Colors.white,),
                  onPressed: () {

                    // showEditProductDialog(context,index,product);
                    // ref.read(productProvider.notifier).addProductCount(data);

                  },
                ),
              ),
            ),
          ),
          width6,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red,
              ),

              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    print(index);
                    // ref.read(salesProvider.notifier).deleteProduct(index);
                  },
                ),
              ),
            ),
          ),
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => products.length;

  @override
  int get selectedRowCount => 0;
}
