import 'package:flutter/material.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:posapp/constants/sized_box.dart';
import 'package:posapp/provider/home_provider/price_provider.dart';
import 'package:posapp/provider/home_provider/products_provider.dart';
import 'package:posapp/provider/product_provider/all_products_provider.dart';
import 'package:posapp/screens/home/widget/widget.dart';
import 'package:posapp/screens/price_confirm_page/price_confirm_page.dart';
import 'package:posapp/screens/product/products_table.dart';
import 'package:posapp/widgets/text_style.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'dart:io';

// import 'package:visibility_detector/visibility_detector.dart';

import '../../provider/product_provider/model/all_products.dart';
import '../sales/sales_view.dart';



class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {

  var focusNode = FocusNode();
  // var focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode = ref.read(productProvider.notifier).focusNode;
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   focusNode = ref.read(productProvider.notifier).focusNode;
    //   // focusNode.requestFocus();
    // });
  }


  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
  }

  // List<AllProduct> filteredProducts = [];
  // AllProduct? selectedProduct;

  //

  String? _barcode;
  // late bool visible;

  TextEditingController barcodeText = TextEditingController();

  final TextEditingController _searchController = TextEditingController();

  // void _filterProducts(String query) {
  //
  //   final allProducts = ref.read(allProductProvider);
  //   setState(() {
  //     filteredProducts = allProducts
  //         .where((product) =>
  //     product.productName.toLowerCase().contains(query.toLowerCase()) ||
  //         product.productCode.toLowerCase().contains(query.toLowerCase()))
  //         .toList();
  //   });
  // }



  @override
  Widget build(BuildContext context) {

    var h = MediaQuery.sizeOf(context).height;
    var w = MediaQuery.sizeOf(context).width;

    ref.read(productProvider.notifier).focusNode.requestFocus();
    final filteredProduct = ref.watch(filterProductProvider);

    return Scaffold(
      appBar: AppBar(
        title: TitleWidget()),
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                BarcodeKeyboardListener(
                  bufferDuration: Duration(milliseconds: 200),
                  onBarcodeScanned: (barcode) {
                    // if (!visible) return;

                    // FocusScope.of(context).requestFocus(focusNode);
                    ref.read(productProvider.notifier).checkAndAddProduct('123');

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
                      children: [
                        ProductTableWidget(),
                        height30,
                        const PricesWidget()
                      ],
                    ),
                    Container(
                      color: Colors.blue.shade100,
                      // height: h,
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

                                      final allProduct = ref.watch(allProductProvider);

                                      if(allProduct.any((product) => product.productCode == val)){
                                          ref.read(productProvider.notifier).checkAndAddProduct(val);
                                          barcodeText.clear();
                                      }

                                      // print(product);

                                      // if(val == '123' || val == '456'){
                                      //
                                      //   ref.read(productProvider.notifier).checkAndAddProduct(val);
                                      //   barcodeText.clear();
                                      //
                                      // }


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
                                  child: Column(
                                    children: [
                                      TextField(
                                        controller: _searchController,
                                        onChanged: (value) {
                                          ref.watch(allProductProvider.notifier).filterProducts(value);
                                          // _filterProducts(value);
                                        },
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                            labelText: 'Sales',
                                        ),
                                      ),
                                      // DropdownButtonFormField<AllProduct>(
                                      //   value: selectedProduct,
                                      //   items: filteredProducts.map(
                                      //         (product) => DropdownMenuItem<AllProduct>(
                                      //       value: product,
                                      //       child: Text('${product.productName} (${product.productCode})'),
                                      //     ),
                                      //   )
                                      //       .toList(),
                                      //   onChanged: (product) {
                                      //     setState(() {
                                      //       selectedProduct = product;
                                      //     });
                                      //   },
                                      //   decoration: InputDecoration(
                                      //     labelText: 'Select Product',
                                      //     border: OutlineInputBorder(),
                                      //   ),
                                      // ),
                                      // const SizedBox(height: 10),
                                      // // Display selected product details
                                      // if (selectedProduct != null)
                                      //   Card(
                                      //     elevation: 4,
                                      //     margin: const EdgeInsets.symmetric(vertical: 8),
                                      //     child: ListTile(
                                      //       title: Text(selectedProduct!.productName),
                                      //       subtitle: Text('Code: ${selectedProduct!.productCode}'),
                                      //       trailing: Text('\$${selectedProduct!.amount}'),
                                      //     ),
                                      //   ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            height20,
                            NumberSwitchWidget(barcodeText),
                            height20,
                            InkWell(
                              onTap: (){

                                final netAmount = ref.read(priceProvider).netAmount;

                                if(netAmount != null && netAmount != '0.00'){
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ConfirmDialogPage(); // Custom dialog content
                                    },
                                  );
                                }

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
                            ),
                            height30,
                            Row(
                              children: [
                                Column(
                                  children: [
                                    buttonContainer(
                                      height: 70,
                                        'NONE', textClr: Colors.white, onTap: (){}),
                                    buttonContainer(
                                      height: 70,
                                        'NONE', textClr:Colors.white, onTap: (){}),
                                  ],
                                ),
                                Column(
                                  children: [
                                    buttonContainer(
                                      height: 70,
                                        'ADMIN', textClr:Colors.white, onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder:
                                          (BuildContext context) => SalesView()));
                                    }),
                                    buttonContainer(
                                      height: 70,
                                        'NONE', textClr: Colors.white, onTap: (){}),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (filteredProduct.isNotEmpty)
              Positioned(
                top: 95, // Position below the TextField
                // left: 56,
                right: 56,
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    // height: 100,
                    width: 300,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder:
                                    (BuildContext context) => ProductTableView()));
                              }, child: Text('See All')),
                              ElevatedButton(onPressed: (){
                                ref.read(allProductProvider.notifier).
                                  pressCloseOrSeeAll('close');
                              }, child: Text('EXIT')),
                            ],
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: filteredProduct.length > 5?
                            5:filteredProduct.length,
                          itemBuilder: (context, index) {
                            final product = filteredProduct[index];
                            return ListTile(
                              title: Text(product.productName),
                              subtitle: Text('Code: ${product.productCode}'),
                              trailing: Text('\$${product.price}'),
                              onTap: () {
                                // Handle product selection

                                ref.read(productProvider.notifier).checkAndAddProduct(product.productCode);

                                // print('Selected: ${product.productName}');
                                setState(() {
                                  _searchController.text = product.productName;
                                  // filteredProducts.clear(); // Hide the container
                                });
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }


}
