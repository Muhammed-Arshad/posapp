import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posapp/constants/sized_box.dart';
import 'package:posapp/provider/provider.dart';
import 'package:posapp/screens/home_page/widget/widget.dart';
import 'package:posapp/screens/price_confirm_page/widget/widget.dart';
import 'package:posapp/widgets/button_widget.dart';


class ConfirmDialogPage extends StatefulWidget {
  const ConfirmDialogPage({super.key});

  @override
  State<ConfirmDialogPage> createState() => _ConfirmDialogPageState();
}

class _ConfirmDialogPageState extends State<ConfirmDialogPage> {


  final TextEditingController amountRcvdCtrl = TextEditingController(text: '');
  final FocusNode amountRcvdFocus = FocusNode();
  final TextEditingController amountChangeCtrl = TextEditingController(text: '');
  final TextEditingController rcvdByCashCtrl = TextEditingController(text: '');
  final FocusNode rcvdByCashFocus = FocusNode();
  final TextEditingController currencyCtrl = TextEditingController(text: 'AED');
  final TextEditingController rateCtrl = TextEditingController(text: '1');
  final TextEditingController rcvdCurrCtrl = TextEditingController(text: '');
  final TextEditingController rcvdByCardCtrl = TextEditingController(text: '');
  final FocusNode rcvdByCardFocus = FocusNode();
  final TextEditingController cardCtrl = TextEditingController(text: '');

  final List<String> numbers = ['7','8','9','4','5','6','1','2','3','0','.','<'];

  @override
  void initState() {
    super.initState();
    rcvdByCashFocus.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
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
          children: [
            Container(
              height: 800,
              decoration: BoxDecoration(
                  color: Colors.white,
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
                              PriceTextField(
                                readOnly: true,
                                ctrl: amountRcvdCtrl,
                                focusNode: amountRcvdFocus,
                                title: 'Received'),
                              width15,
                              PriceTextField(
                                readOnly: true,
                                ctrl: amountChangeCtrl,
                                headerClr: Colors.orange,
                                title: 'Change'),
                              width15,
                              PriceTextField(
                                ctrl: rcvdByCashCtrl,
                                title: switch(ref.watch(paidViaProvider)){
                                  PaidVia.cash => 'Received By Cash',
                                  PaidVia.card => 'Received By Card',
                                  PaidVia.cardPlusCash => 'Received By Cash'},
                                onChanged: (val){
                                  getPriceWithCash(null, ref.read(priceProvider), val);
                                },
                                onTap: (){
                                  if(rcvdByCashCtrl.text == '0'){
                                    rcvdByCashCtrl.clear();
                                  }
                                },
                                focusNode: rcvdByCashFocus,
                              ),
                              width15,
                              PriceTextField(
                                ctrl: rcvdByCardCtrl,
                                title: ref.watch(paidViaProvider) == PaidVia.cardPlusCash?
                                'Received By Card':'',
                                focusNode: rcvdByCardFocus,
                                readOnly: paidVia == PaidVia.cash
                                    || paidVia == PaidVia.card?true:false,
                                onChanged: (val) {
                                  getPriceWithCard(null, ref.read(priceProvider), val);
                                },
                                onTap: () {

                                  if((ref.read(paidViaProvider) == PaidVia.cash ||
                                      ref.read(paidViaProvider) == PaidVia.card)){
                                    rcvdByCashFocus.requestFocus();
                                  }

                                  if(rcvdByCardCtrl.text == '0'){
                                    rcvdByCardCtrl.clear();
                                  }
                                },
                              ),
                            ],
                          ),
                          height20,
                          Row(
                            children: [
                              PriceTextField(
                                ctrl: currencyCtrl,
                                readOnly: true,
                                title: 'Currency',
                              ),
                              width15,
                              PriceTextField(
                                ctrl: rateCtrl,
                                readOnly: true,
                                title: 'Rate',
                              ),
                              width15,
                              PriceTextField(
                                ctrl: rcvdCurrCtrl,
                                readOnly: true,
                                title: 'Received Curr',
                              ),
                              width15,
                              PriceTextField(
                                ctrl: cardCtrl,
                                readOnly: true,
                                title: 'Received by Card',
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

                                        if(rcvdByCashFocus.hasFocus){
                                          rcvdByCashCtrl.selection =
                                              TextSelection.collapsed(offset: rcvdByCashCtrl.text.length);
                                          getPriceWithCash(i, price, num);
                                        }else if(rcvdByCardFocus.hasFocus
                                            && ref.read(paidViaProvider) == PaidVia.cardPlusCash){
                                          getPriceWithCard(i, price, num);

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

  void getPriceWithCard(int? i,TotalPriceModel price,String num){
    if(i != null &&(i == numbers.length-1)){
      if(rcvdByCardCtrl.text.isNotEmpty){
        rcvdByCardCtrl.text = rcvdByCardCtrl.text.substring(0, rcvdByCardCtrl.text.length - 1);
      }

      if(rcvdByCardCtrl.text == '0'){
        rcvdByCardCtrl.clear();
      }
      getPriceWithCashOrCardHelper(price);

    }else{
      if(i != null){
        if(rcvdByCardCtrl.text == '0'){
          rcvdByCardCtrl.clear();
        }
        rcvdByCardCtrl.text = rcvdByCardCtrl.text + num;
        getPriceWithCashOrCardHelper(price);
      }else{
        getPriceWithCashOrCardHelper(price);
      }
    }
  }

  void getPriceWithCash(int? i,TotalPriceModel price,String num){
    if(i != null &&(i == numbers.length-1)){
      if(rcvdByCashCtrl.text.isNotEmpty){
        rcvdByCashCtrl.text = rcvdByCashCtrl.text.substring(0, rcvdByCashCtrl.text.length - 1);
      }
      if(rcvdByCashCtrl.text == '0'){
        rcvdByCashCtrl.clear();
      }
      getPriceWithCashOrCardHelper(price);
    }else{
      if(i != null){
        if(rcvdByCashCtrl.text == '0'){
          rcvdByCashCtrl.clear();
        }
        rcvdByCashCtrl.text = rcvdByCashCtrl.text + num;
        getPriceWithCashOrCardHelper(price);
      }else{
        getPriceWithCashOrCardHelper(price);
      }
    }
  }

  void getPriceWithCashOrCardHelper(TotalPriceModel price){
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

  @override
  void dispose() {
    super.dispose();
    amountRcvdFocus.dispose();
    rcvdByCashFocus.dispose();
    rcvdByCardFocus.dispose();
  }
}