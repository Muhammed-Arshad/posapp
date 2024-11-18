import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/sized_box.dart';
import '../../../provider/home_provider/price_provider.dart';

class CardOrCashButton extends ConsumerWidget {
  const CardOrCashButton({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final paidVia = ref.watch(paidViaProvider);
    double w = MediaQuery.of(context).size.width;

    return Column(
          children: [
            GestureDetector(
              onTap: (){
                ref.read(paidViaProvider.notifier).state = PaidVia.cash;
              },
              child: Container(
                  height: 30,
                  width: w>500 ?550/2.5:w / 4,
                  decoration: BoxDecoration(
                    border: paidVia == PaidVia.cash?
                    Border.all(width: 3,color: Colors.yellow):null,
                    color: Colors.grey,),
                  child: Center(child: Text('CASH'))
              ),
            ),
            height10,
            GestureDetector(
              onTap: (){
                ref.read(paidViaProvider.notifier).state = PaidVia.card;
              },
              child: Container(
                  height: 30,
                  width: w>500 ?550/2.5:w / 4,
                  decoration: BoxDecoration(
                    border: paidVia == PaidVia.card?
                    Border.all(width: 3,color: Colors.yellow):null,
                    color: Colors.grey,),
                  child: Center(child: Text('CARD'))
              ),
            ),
            height10,
            GestureDetector(
              onTap: (){
                ref.read(paidViaProvider.notifier).state = PaidVia.cardPlusCash;
              },
              child: Container(
                  height: 30,
                  width: w>500 ?550/2.5:w / 4,
                  decoration: BoxDecoration(
                      border: paidVia == PaidVia.cardPlusCash?
                      Border.all(width: 3,color: Colors.yellow):null,
                      color: Colors.grey),
                  child: Center(child: Text('CASH - CARD'))
              ),
            ),
          ],
        );
  }
}
