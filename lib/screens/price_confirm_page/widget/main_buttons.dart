import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posapp/provider/home_provider/products_provider.dart';
import 'package:posapp/provider/sale_provider/sales_provider.dart';

import '../../../widgets/button_widget.dart';

class MainButtons extends ConsumerWidget {
  const MainButtons({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final product = ref.read(productProvider);

    return Row(
      children: [
        ButtonWidget(onTap: () {
          Navigator.pop(context);
        }, btnText: 'CANCEL',width: 150,btnColor: Colors.red.shade300),
        ButtonWidget(onTap: () {
          ref.read(salesProvider.notifier).addToSale(product);
          ref.read(productProvider.notifier).clearProducts();
          Navigator.pop(context);
          ref.read(productProvider.notifier).focusNode.requestFocus();
        }, btnText: 'OK',width: 150),
      ],
    );
  }
}
