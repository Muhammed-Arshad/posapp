import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/sized_box.dart';
import '../../../provider/home_provider/model/total_price_model.dart';
import '../../../provider/home_provider/price_provider.dart';
import '../../../widgets/text_style.dart';

class PricesWidget extends ConsumerWidget {
  const PricesWidget({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final w = MediaQuery.of(context).size.width;

    TotalPriceModel provider = ref.watch(priceProvider);

    return Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Container(
                width: w*0.23,
                child: Column(
                  children: [
                    cardContainer(context,'Sub Total', provider.subTotal.toString(),),
                    cardContainer(context,'Bill Disc',provider.billDisc.toString()),
                    cardContainer(context,'Total',provider.total.toString()),
                    cardContainer(context,'Taxable',provider.taxable.toString()),
                    cardContainer(context,'VAT @5%',provider.vat.toString()),
                  ],
                ),
              ),
              width15,
              Container(
                width: w*0.23,
                child: Column(
                  children: [
                    cardContainer(context,'Net Amount',provider.netAmount.toString(),textBigCheck: true,bgColor: Colors.blueAccent),
                    cardContainer(context,'Recvd Amt',provider.rcvdAmount.toString()),
                    cardContainer(context,'Balance',provider.balance.toString()),
                    cardContainer(context,'Item Disc',provider.itemDisc.toString()),
                    cardContainer(context,'Recvd Curr.',provider.recvdCurr.toString()),
                  ],
                ),
              ),
            ],
          ),
    );
  }

  Widget cardContainer(context,String text,String price,
      {bool textBigCheck = false,Color bgColor = Colors.blueGrey}){



    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextWidget().customTextB(text),
        Container(
            height: 30,
            width: MediaQuery.sizeOf(context).width*0.1,
            decoration: BoxDecoration(
                color: bgColor),
            child: Center(child: textBigCheck?CustomTextWidget().customTextBL(price):Text(price,style: TextStyle(color: Colors.white),))
        ),
        // Card(
        //     child: Container(
        //         margin: const EdgeInsets.all(3.0),
        //         width: MediaQuery.of(context).size.width*0.1,
        //         height: 20,
        //         child: Center(
        //           child: Text(price,
        //             style: const TextStyle(fontSize: 15),
        //           ),
        //         )
        //     ))
      ],
    );
  }
}
