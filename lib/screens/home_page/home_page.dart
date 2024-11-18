import 'package:flutter/material.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:posapp/constants/sized_box.dart';
import 'package:posapp/provider/home_provider/products_provider.dart';
import 'package:posapp/screens/home_page/widget/widget.dart';
import 'package:posapp/screens/price_confirm_page/price_confirm_page.dart';
import 'package:posapp/widgets/custom_textfield.dart';
import 'package:posapp/widgets/text_style.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

import 'package:visibility_detector/visibility_detector.dart';

var text = CustomTextWidget();
var textField = CustomTextField();

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  // class HomePage extends StatelessWidget {

  @override
  void initState() {
    // var provider = Provider.of<HomeProvider>(context, listen: false);

    // Future.delayed(Duration.zero).then((value) {
    //   provider.getTotalAmount();
    // });

    // provider.activeCtrl.addListener(provider.getConfirmDialogBoxData);

    super.initState();
  }

  String? _barcode;
  // late bool visible;

  TextEditingController barcodeText = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var h = MediaQuery.sizeOf(context).height;
    var w = MediaQuery.sizeOf(context).width;

    var focusNode = FocusNode();

    return Scaffold(
      appBar: AppBar(
        title: TitleWidget()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BarcodeKeyboardListener(
              bufferDuration: Duration(milliseconds: 200),
              onBarcodeScanned: (barcode) {
                // if (!visible) return;

                // FocusScope.of(context).requestFocus(focusNode);

                print(barcode);
                setState(() {
                  // FocusScope.of(context).requestFocus(focusNode);
                  _barcode = barcode;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _barcode == null ? 'SCAN BARCODE' : 'BARCODE: $_barcode',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
              // useKeyDownEvent: Platform.isWindows,
              // useKeyDownEvent: true,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    ProductTableWidget(),
                    height30,
                    PricesWidget()
                  ],
                ),
                Container(
                  // color: Colors.blue.shade200,
                  color: Colors.blue.shade100,
                  height: h,
                  width: w*0.4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: TextField(
                                focusNode: focusNode,
                                // controller: provider.barcodeCheck,
                                controller: barcodeText,
                                onChanged: (val){
                                  if(val == '123' || val == '456'){

                                    ref.read(productProvider.notifier).checkAndAddProduct(val);
                                    barcodeText.clear();

                                  }


                                },
                                onEditingComplete: (){
                                  FocusScope.of(context).requestFocus(focusNode);
                                },
                                onTap: (){
                                  // provider.activeCtrl = provider.barcodeCheck;
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Sales Ret'
                                ),
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                              flex: 1,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                    labelText: 'Sales',
                                ),
                              ),
                            ),
                          ],
                        ),
                        height20,
                        NumberSwitchWidget(barcodeText),
                        height20,
                        InkWell(
                          onTap: (){

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ConfirmDialogPage(); // Custom dialog content
                                },
                              );

                            // if(provider.activeCtrl.text.isNotEmpty){
                            //   provider.addProduct();
                            // }else{
                            //   showDialog(
                            //     context: context,
                            //     builder: (BuildContext context) {
                            //       return ConfirmDialog(); // Custom dialog content
                            //     },
                            //   );
                            // }

                            // provider.tableData.add({'No': 1, 'itemCode': 'A001', 'itemName': 'Item 1', 'Quantity': 1, 'amount': 20, 'totalAmount': 0});


                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                              border: Border.all(
                                color: Colors.white,
                                width: 2, //                   <--- border width here
                              ),
                            ),
                            height: 60,
                            child: Center(child: CustomTextWidget().customTextB('ENTER',color: Colors.white)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


}
