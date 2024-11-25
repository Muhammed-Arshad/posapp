import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posapp/provider/sale_provider/sales_provider.dart';
import 'package:posapp/screens/sales/add_stock/add_stocks.dart';
import 'package:posapp/screens/sales/sales_data/invoice_view.dart';
import 'package:posapp/screens/sales/sales_data/sales_data_table.dart';
import 'package:posapp/screens/sales/stocks_view/stocks_view.dart';
import 'package:posapp/screens/sales/widget/nav_bar.dart';


class SalesView extends StatelessWidget {
  SalesView({super.key});

  final List<Widget> view = [
    SalesDataTable(),
    AddStocks(),
    StocksView(),
    InvoiceScreen()
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Row(
        children: [
          Menu(),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final selectedView = ref.watch(selectedMenuProvider);
              return Expanded(
                flex: 8,
                  child: view[selectedView]);
            },)
        ],
      ),
    );
  }
}

