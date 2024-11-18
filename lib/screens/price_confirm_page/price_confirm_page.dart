import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posapp/constants/sized_box.dart';
import 'package:posapp/provider/provider.dart';
import 'package:posapp/screens/home_page/widget/widget.dart';
import 'package:posapp/screens/price_confirm_page/widget/bill_amount.dart';
import 'package:posapp/screens/price_confirm_page/widget/card_or_cash_button.dart';
import 'package:posapp/screens/price_confirm_page/widget/currency_list.dart';
import 'package:posapp/screens/price_confirm_page/widget/main_buttons.dart';
import 'package:posapp/widgets/widget.dart';

import '../../widgets/button_widget.dart';


class ConfirmDialogPage extends StatelessWidget {
  ConfirmDialogPage({super.key});


  final TextEditingController amountRcvdCtrl = TextEditingController(text: '');
  final FocusNode amountRcvdFocus = FocusNode();
  final TextEditingController amountChangeCtrl = TextEditingController(text: '');
  final TextEditingController rcvdByCashCtrl = TextEditingController(text: '');
  final FocusNode rcvdByCashCtrlFocus = FocusNode();
  final TextEditingController currencyCtrl = TextEditingController(text: 'AED');
  final TextEditingController rateCtrl = TextEditingController(text: '1');
  final TextEditingController rcvdCurrCtrl = TextEditingController(text: '');
  final TextEditingController rcvdByCardCtrl = TextEditingController(text: '');
  final FocusNode rcvdByCardFocus = FocusNode();
  final TextEditingController cardCtrl = TextEditingController(text: '');

  final List<String> numbers = ['7','8','9','4','5','6','1','2','3','0','.','<'];

  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    List<Map<String,String>> listsData = [
      {'AED':'1'}, {'\$':'5'}, {'SR':'6'}, {'QAR':'1'}, {'OMR':"2"}, {'KWD':'3'}
    ];


    amountRcvdFocus.requestFocus();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        // width: 1300,
        height: 800,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.blueAccent,width: 5,)
        ),
        padding: EdgeInsets.all(20.0),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 800,
              decoration: BoxDecoration(
                  color: Colors.white,
                  // borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.blue.shade50,width: 5,)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {

                      final paidVia = ref.watch(paidViaProvider);

                      return Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 69,
                                width: w>500 ?550/4:w / 5,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  children: [
                                    Container(
                                      color: Colors.green,
                                      child: Center(
                                        child: Text('Received'),
                                      ),
                                    ),
                                    TextStyles().onlyNumberTFFF(
                                        onChanged: (val){
                                          getPrice(null, ref.read(priceProvider), val);
                                        },
                                        cont: amountRcvdCtrl,
                                        context: context,
                                        focusNode: amountRcvdFocus),
                                  ],
                                ),
                              ),
                              width15,
                              Container(
                                height: 69,
                                width: w>500 ?550/4:w / 5,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  children: [
                                    Container(
                                      color: Colors.green,
                                      child: Center(
                                        child: Text('Change'),
                                      ),
                                    ),
                                    TextStyles().onlyNumberTFFF(
                                        readOnly: true,
                                        cont: amountChangeCtrl,context: context),
                                  ],
                                ),
                              ),
                              width15,
                              Container(
                                height: 69,
                                width: w>500 ?550/4:w / 5,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  children: [
                                    Container(
                                      color: Colors.green,
                                      child: Center(

                                        child: switch(ref.watch(paidViaProvider)){
                                          PaidVia.cash => Text('Received By Cash'),
                                          PaidVia.card => Text('Received By Card'),
                                          PaidVia.cardPlusCash => Text('Received By Cash')},
                                      ),
                                    ),
                                    TextStyles().onlyNumberTFFF(
                                        onChanged: (val){
                                          getPriceWithCash(null, ref.read(priceProvider), val);
                                        },
                                        onTap: (){

                                          if(rcvdByCashCtrl.text == '0'){
                                            rcvdByCashCtrl.clear();
                                          }

                                        },
                                        focusNode: rcvdByCashCtrlFocus,
                                        cont: rcvdByCashCtrl,context: context),
                                  ],
                                ),
                              ),
                              width15,
                              Container(
                                height: 69,
                                width: w>500 ?550/4:w / 5,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  children: [
                                    Container(
                                      color: Colors.green,
                                      child: Center(
                                        child: ref.watch(paidViaProvider) == PaidVia.cardPlusCash?
                                        Text('Received By Card'):Text(''),
                                      ),
                                    ),
                                    TextStyles().onlyNumberTFFF(
                                        readOnly: paidVia == PaidVia.cash
                                            || paidVia == PaidVia.card?true:false,
                                        onChanged: (val){
                                          getPriceWithCard(null, ref.read(priceProvider), val);
                                        },
                                        onTap: (){
                                          // print('ARSHAD--');
                                          // amountRcvdFocus.unfocus();
                                          // rcvdByCardFocus.requestFocus();

                                          if(rcvdByCardCtrl.text == '0'){
                                            rcvdByCardCtrl.clear();
                                          }
                                        },
                                        cont: rcvdByCardCtrl,context: context,focusNode: rcvdByCardFocus),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          height20,
                          Row(
                            children: [
                              Container(
                                height: 69,
                                width: w>500 ?550/4:w / 5,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  children: [
                                    Container(
                                      color: Colors.green,
                                      child: Center(
                                        child: Text('Currency'),
                                      ),
                                    ),
                                    TextStyles().onlyNumberTFFF(
                                        readOnly: true,
                                        cont: currencyCtrl,context: context),
                                  ],
                                ),
                              ),
                              width15,
                              Container(
                                height: 69,
                                width: w>500 ?550/4:w / 5,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  children: [
                                    Container(
                                      color: Colors.green,
                                      child: Center(
                                        child: Text('Rate'),
                                      ),
                                    ),
                                    TextStyles().onlyNumberTFFF(
                                        readOnly: true,
                                        cont: rateCtrl,context: context),
                                  ],
                                ),
                              ),
                              width15,
                              Container(
                                height: 69,
                                width: w>500 ?550/4:w / 5,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  children: [
                                    Container(
                                      color: Colors.green,
                                      child: Center(
                                        child: Text('Received Curr'),
                                      ),
                                    ),
                                    TextStyles().onlyNumberTFFF(
                                        readOnly: true,
                                        cont: rcvdCurrCtrl,context: context),
                                  ],
                                ),
                              ),
                              width15,
                              Container(
                                height: 69,
                                width: w>500 ?550/4:w / 5,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  children: [
                                    Container(
                                      color: Colors.green,
                                      child: Center(
                                        child: Text('Received by Card'),
                                      ),
                                    ),
                                    TextStyles().onlyNumberTFFF(
                                        readOnly: true,
                                        cont: cardCtrl,context: context),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  height30,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Consumer(
                            builder: (BuildContext context, WidgetRef ref, Widget? child) {

                              TotalPriceModel price = ref.read(priceProvider);

                              return SizedBox(
                                height: 300,
                                width: 300,
                                child: GridView.builder(

                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio: 1.5
                                    ),
                                    itemCount: numbers.length,
                                    itemBuilder: (BuildContext context, int i) {

                                      final num = numbers[i];

                                      return buttonContainer(num, bgClr: Color(0xfff0f0f0), onTap: (){

                                        if(amountRcvdFocus.hasFocus){
                                          getPrice(i,price,num);
                                        }else if(rcvdByCardFocus.hasFocus){
                                          // rcvdByCardCtrl.text = rcvdByCardCtrl.text + num;
                                          //
                                          // if(i == numbers.length-1){
                                          //   cardCtrl.text = cardCtrl.text.substring(0, cardCtrl.text.length - 1);
                                          //   if(cardCtrl.text.isEmpty){
                                          //     cardCtrl.text = '0';
                                          //   }
                                          //   cardCtrl.text =
                                          //       ((double.parse(cardCtrl.text)) -
                                          //           (double.parse(price.netAmount.toString()))).toString();
                                          //
                                          // }else{
                                          //   if(cardCtrl.text == '0'){
                                          //     cardCtrl.clear();
                                          //   }
                                          //   cardCtrl.text = cardCtrl.text + num;
                                          //   rcvdByCashCtrl.text = cardCtrl.text;
                                          //   amountChangeCtrl.text =
                                          //       ((double.parse(cardCtrl.text)) -
                                          //           (double.parse(price.netAmount.toString()))).toString();
                                          // }
                                        }

                                      });
                                    }),
                              );
                            },
                          ),
                          MainButtons()
                        ],
                      ),
                      CardOrCashButton()
                    ],
                  )

                  // Add your custom content here
                ],
              ),
            ),
            Container(
              height: 800,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue.shade50,width: 5,)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  BillAmount(),
                  CurrencyList(),
                  height30,
                  ButtonWidget(onTap: () {  }, btnText: 'ENTER',width: 200),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getPrice(int? i,TotalPriceModel price,String num){

    if(i != null &&(i == numbers.length-1)){
      if(amountRcvdCtrl.text.isNotEmpty){
        amountRcvdCtrl.text = amountRcvdCtrl.text.substring(0, amountRcvdCtrl.text.length - 1);
      }
      if(amountRcvdCtrl.text.isEmpty){
        rcvdByCashCtrl.clear();
        amountChangeCtrl.clear();
      }else{
        rcvdByCashCtrl.text = amountRcvdCtrl.text;
        amountChangeCtrl.text =
            ((double.parse(amountRcvdCtrl.text)) -
                (double.parse(price.netAmount.toString()))).toString();
      }
    }else{
      if(i != null){
        amountRcvdCtrl.text = amountRcvdCtrl.text + num;
        getPriceHelper(price);
      }
      getPriceHelper(price);
    }
  }

  void getPriceHelper(TotalPriceModel price){
    if(amountRcvdCtrl.text.isEmpty){
      rcvdByCashCtrl.clear();
      amountChangeCtrl.clear();
    }else{
      rcvdByCashCtrl.text = amountRcvdCtrl.text;
      amountChangeCtrl.text =
          ((double.parse(amountRcvdCtrl.text)) -
              (double.parse(price.netAmount.toString()))).toString();
    }
  }

  void getPriceWithCard(int? i,TotalPriceModel price,String num){
    if(i != null &&(i == numbers.length-1)){
      if(amountRcvdCtrl.text.isNotEmpty){
        amountRcvdCtrl.text = amountRcvdCtrl.text.substring(0, amountRcvdCtrl.text.length - 1);
      }
      if(amountRcvdCtrl.text.isEmpty){
        rcvdByCashCtrl.clear();
        amountChangeCtrl.clear();
      }else{
        rcvdByCashCtrl.text = amountRcvdCtrl.text;
        amountChangeCtrl.text =
            ((double.parse(amountRcvdCtrl.text)) -
                (double.parse(price.netAmount.toString()))).toString();
      }
    }else{
      if(i != null){
        amountRcvdCtrl.text = amountRcvdCtrl.text + num;
        getPriceHelper(price);
      }
      if(rcvdByCardCtrl.text.isEmpty && rcvdByCashCtrl.text.isEmpty){
        amountChangeCtrl.clear();
        amountRcvdCtrl.clear();
      }else{

        if(rcvdByCardCtrl.text.isEmpty){
          rcvdByCardCtrl.text = '0';
        }

        if(rcvdByCashCtrl.text.isEmpty){
          rcvdByCashCtrl.text = '0';
        }

        double total = ((double.parse(rcvdByCardCtrl.text)) + (double.parse(rcvdByCashCtrl.text)));
        amountRcvdCtrl.text = total.toString();
        amountChangeCtrl.text =
            ((total) - (double.parse(price.netAmount.toString()))).toString();
      }
    }
  }

  void getPriceWithCash(int? i,TotalPriceModel price,String num){
    if(i != null &&(i == numbers.length-1)){
      if(amountRcvdCtrl.text.isNotEmpty){
        amountRcvdCtrl.text = amountRcvdCtrl.text.substring(0, amountRcvdCtrl.text.length - 1);
      }
      if(amountRcvdCtrl.text.isEmpty){
        rcvdByCashCtrl.clear();
        amountChangeCtrl.clear();
      }else{
        rcvdByCashCtrl.text = amountRcvdCtrl.text;
        amountChangeCtrl.text =
            ((double.parse(amountRcvdCtrl.text)) -
                (double.parse(price.netAmount.toString()))).toString();
      }
    }else{
      if(i != null){
        amountRcvdCtrl.text = amountRcvdCtrl.text + num;
        getPriceHelper(price);
      }
      if(rcvdByCashCtrl.text.isEmpty){
        amountChangeCtrl.clear();
        amountRcvdCtrl.clear();
      }else{

        if(rcvdByCardCtrl.text.isEmpty){
          rcvdByCardCtrl.text = '0';
        }

        if(rcvdByCashCtrl.text.isEmpty){
          rcvdByCashCtrl.text = '0';
        }

        // rcvdByCardCtrl.text = '0';

        double total = ((double.parse(rcvdByCardCtrl.text)) + (double.parse(rcvdByCashCtrl.text)));

        amountRcvdCtrl.text = total.toString();

        amountChangeCtrl.text =
            ((total) - (double.parse(price.netAmount.toString()))).toString();
      }
    }
  }



}