import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posapp/provider/provider.dart';

import 'package:posapp/widgets/widget.dart';

class BillAmount extends StatelessWidget {
  const BillAmount({super.key});

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;

    return Container(
      height: 70,
      width: w>500 ?550/3:w / 4,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Container(
            height: 30,
            color: Colors.blueAccent,
            child: Center(
              child: Text('Bill amount'),
            ),
          ),
          Consumer(
            builder: (BuildContext context, ref, Widget? child) {

              TotalPriceModel price = ref.read(priceProvider);

              return Container(
                height: 40,
                color: Colors.grey.shade200,
                child: Center(
                  // child: ts.customTextBL(provider.totalAmount[0].netAmount.toString()),
                  child: CustomTextWidget().customTextBL(price.netAmount.toString()),
                ),
              );
            },
            child: Container(
              height: 40,
              color: Colors.grey.shade200,
              child: Center(
                // child: ts.customTextBL(provider.totalAmount[0].netAmount.toString()),
                child: CustomTextWidget().customTextBL(123.toString()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
