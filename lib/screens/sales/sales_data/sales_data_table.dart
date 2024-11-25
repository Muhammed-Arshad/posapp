import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:posapp/constants/sized_box.dart';
import 'package:posapp/screens/sales/sales_data/widget/textfield_widget.dart';

import '../../../provider/home_provider/model/product_model.dart';
import '../../../provider/product_provider/all_products_provider.dart';
import '../../../provider/sale_provider/sales_provider.dart';
import '../../home/widget/quantity_dialogbox.dart';

class SalesDataTable extends ConsumerStatefulWidget {
  const SalesDataTable({super.key});

  @override
  ConsumerState<SalesDataTable> createState() => _SalesDataTableState();
}

class _SalesDataTableState extends ConsumerState<SalesDataTable> {

  DateTime? fromDate;
  DateTime? toDate;

  // final List<Product> products = List.generate(
  //   20,
  //       (index) => Product(
  //     no: index + 1,
  //     productCode: '0',
  //     itemName: 'Product ${index + 1}',
  //     price: (index + 1) * 10.0,
  //     dateTime: DateTime(2024, 11, 1).add(Duration(days: index)),
  //         quantity: 5, fixedPrice: 10, fixedUnit: ProductUnit.g, totalAmount: 100,
  //   ),
  // );

  // List<Product> get filteredProducts {
  //   if (fromDate == null && toDate == null) return products;
  //   return products.where((product) {
  //     final isAfterFromDate = fromDate == null || product.dateTime!.isAfter(fromDate!.subtract(Duration(days: 1)));
  //     final isBeforeToDate = toDate == null || product.dateTime!.isBefore(toDate!.add(Duration(days: 1)));
  //     return isAfterFromDate && isBeforeToDate;
  //   }).toList();
  // }

  Future<void> selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isFromDate) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final sale = ref.watch(salesProvider);

    return Container(
      height: MediaQuery.sizeOf(context).height,
      color: Colors.green,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: DatePickerField(
                    labelText: 'From Date',
                    icon: Icons.calendar_today,
                    selectedDate: fromDate,
                    onTap: () => selectDate(context, true),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DatePickerField(
                    labelText: 'To Date',
                    icon: Icons.calendar_today,
                    selectedDate: toDate,
                    onTap: () => selectDate(context, true),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: PaginatedDataTable(
                columnSpacing: 30,
                header: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Products'),
                    ElevatedButton(onPressed: (){

                      ref.read(selectedMenuProvider.notifier).state = 3;

                      // ref.read(salesProvider.notifier).getSalesPrint();
                    }, child: Text('Print'))
                  ],
                ),
                rowsPerPage: 10,
                columns: const [
                  DataColumn(label: Text('SI No')),
                  DataColumn(label: Text('Product Code')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Quantity')),
                  DataColumn(label: Text('Price')),
                  DataColumn(label: Text('Total Amount')),
                  DataColumn(label: Text('Date Added')),
                  DataColumn(label: Text('Time Added')),
                  DataColumn(label: Text('Action')),
                ],
                source: ProductDataSource(sale,ref,context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDataSource extends DataTableSource {
  BuildContext context;
  WidgetRef ref;
  final List<Product> products;

  ProductDataSource(this.products,this.ref,this.context);

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
    var unit = '';

    switch(product.productUnit){

      case ProductUnit.g:
        unit = 'gram';
      case ProductUnit.kg:
        unit = 'Kg';
      case ProductUnit.ml:
        unit = 'ml';
      case ProductUnit.l:
        unit = 'L';
    }

    return DataRow(cells: [
      DataCell(Text((index + 1).toString())),
      DataCell(Text(product.productCode)),
      DataCell(Text(product.productName)),
      DataCell(Text("${product.quantity.toString()} $unit")),
      DataCell(Text(product.price.toString())),
      DataCell(Text(product.totalAmount.toString())),
      DataCell(Text(product.dateTime == null
          ? ''
          : product.dateTime!.toLocal().toString().split(' ')[0])),
      DataCell(
          Text(DateFormat('HH:mm:ss').format(product.dateTime!).toString())),
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

                    showEditProductDialog(context,index,product);
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
                    ref.read(salesProvider.notifier).deleteProduct(index);
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
