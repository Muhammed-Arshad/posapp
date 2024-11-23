import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:posapp/provider/sale_provider/sales_provider.dart';

import '../../provider/home_provider/model/product_model.dart';

class SalesView extends ConsumerStatefulWidget {
  const SalesView({super.key});

  @override
  ConsumerState<SalesView> createState() => _SalesViewState();
}

class _SalesViewState extends ConsumerState<SalesView> {
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

    return Scaffold(
      body: Row(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                  height: MediaQuery.sizeOf(context).height,
                  color: Colors.red,
                  child: Text('Sales'))),
          Expanded(
              flex: 8,
              child: Container(
                height: MediaQuery.sizeOf(context).height,
                color: Colors.green,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: 'From Date',
                                suffixIcon: Icon(Icons.calendar_today),
                              ),
                              onTap: () => selectDate(context, true),
                              controller: TextEditingController(
                                text: fromDate != null
                                    ? fromDate!.toLocal().toString().split(' ')[0]
                                    : '',
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: 'To Date',
                                suffixIcon: Icon(Icons.calendar_today),
                              ),
                              onTap: () => selectDate(context, false),
                              controller: TextEditingController(
                                text: toDate != null
                                    ? toDate!.toLocal().toString().split(' ')[0]
                                    : '',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: PaginatedDataTable(
                          columnSpacing: 40,
                          header: Text('Products'),
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
                          ],
                          source: ProductDataSource(sale),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class ProductDataSource extends DataTableSource {
  final List<Product> products;

  ProductDataSource(this.products);

  @override
  DataRow? getRow(int index) {
    if (index >= products.length) return null;
    final product = products[index];

    return DataRow(cells: [
      DataCell(Text((index + 1).toString())),
      DataCell(Text(product.productCode)),
      DataCell(Text(product.productName)),
      DataCell(Text(product.quantity.toString())),
      DataCell(Text(product.price.toString())),
      DataCell(Text(product.totalAmount.toString())),
      DataCell(Text(product.dateTime == null
          ? ''
          : product.dateTime!.toLocal().toString().split(' ')[0])),
      DataCell(
          Text(DateFormat('HH:mm:ss').format(product.dateTime!).toString())),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => products.length;

  @override
  int get selectedRowCount => 0;
}
