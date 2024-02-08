import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posapp/constants/sized_box.dart';
import 'package:posapp/provider/home_provider/home_provider.dart';
import 'package:posapp/screens/home_page/widget/confirm_dialog.dart';
import 'package:posapp/screens/home_page/widget/custom_container.dart';
import 'package:posapp/widgets/custom_textfield.dart';
import 'package:posapp/widgets/text_style.dart';
import 'package:provider/provider.dart';

var text = CustomTextWidget();
var textField = CustomTextField();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}




class _HomePageState extends State<HomePage> {
  // class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var h = MediaQuery.sizeOf(context).height;
    var w = MediaQuery.sizeOf(context).width;


    return Consumer<HomeProvider>(builder: (context, provider, child) {

      Future.delayed(Duration.zero).then((value) {
        provider.getTotalAmount();
      });


    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Bill # C12H4F55',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Counter: 01',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  'CASH Cash: 0.00',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Card: 0.00',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  '30-Jan-2024',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  '09:02 PM',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
        )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // border: Border(
                        //   right: BorderSide(width: 2.0, color: Colors.lightBlue.shade600),
                        // ),
                        border: Border.all(width: 1.0, color: Colors.grey.shade600),
                      ),
                      height: h/2,
                      width: w*0.6,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            FittedBox(
                              child: DataTable(
                                columns: [
                                  DataColumn(label: text.customTextB('SI No')),
                                  DataColumn(label: text.customTextB('Item Code')),
                                  DataColumn(label: text.customTextB('Item Name')),
                                  DataColumn(label: text.customTextB('Quantity')),
                                  DataColumn(label: text.customTextB('Price')),
                                  DataColumn(label: text.customTextB('Total Price')),
                                  DataColumn(label: text.customTextB('Actions')),
                                ],
                                rows: provider.tableData.map(
                                      (data) => DataRow(
                                        color: MaterialStateProperty.all<Color>(Colors.orange.shade100),
                                          cells: [
                                    DataCell(text.customTextB(data['No'].toString())),
                                    DataCell(text.customTextB(data['itemCode'])),
                                    DataCell(text.customTextB(data['itemName'].toString().toUpperCase())),
                                    DataCell(text.customTextB(data['Quantity'].toString())),
                                    DataCell(text.customTextB((data['amount']).toString())),
                                    DataCell(text.customTextB((data['amount'] * data['Quantity']).toString())),
                                    DataCell(Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                                          child: Container(
                                            // height: 40,
                                            // width: 40,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.blueAccent,
                                            ),
                                            child: Center(
                                              child: IconButton(
                                                icon: Icon(Icons.add,color: Colors.white,),
                                                onPressed: () {
                                                  // setState(() {
                                                  data['Quantity']++;
                                                  // });

                                                  provider.getPriceTotal(provider.tableData);

                                                  // provider.totalAmount[0].subTotal = '100';

                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.remove),
                                          onPressed: () {

                                            if(data['Quantity'] <= 1){
                                              return;
                                            }

                                            // setState(() {
                                              data['Quantity']--;
                                            // });

                                            provider.getPriceTotal(provider.tableData);
                                          },
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.red,
                                            ),

                                            child: Center(
                                              child: IconButton(
                                                icon: const Icon(Icons.close),
                                                onPressed: () {
                                                  provider.tableData.remove(data);
                                                    provider.getPriceTotal(provider.tableData);
                                                },
                                              ),
                                            ),
                                          ),
                                        ),

                                      ],
                                    )),
                                  ]),
                                )
                                    .toList(),
                              ),
                            ),

                          ],
                        ),
                      )
                    ),
                    height30,
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        children: [
                          Container(
                            width: w*0.23,
                            child: Column(
                              children: [
                                cardContainer('Sub Total',
                                  provider.totalAmount.isEmpty?'':provider.totalAmount[0].subTotal.toString(),),
                                cardContainer('Bill Disc',provider.totalAmount.isEmpty?'':provider.totalAmount[0].billDisc.toString()),
                                cardContainer('Total',provider.totalAmount.isEmpty?'':provider.totalAmount[0].total.toString()),
                                cardContainer('Taxable',provider.totalAmount.isEmpty?'':provider.totalAmount[0].taxable.toString()),
                                cardContainer('VAT @5%',provider.totalAmount.isEmpty?'':provider.totalAmount[0].vat.toString()),
                              ],
                            ),
                          ),
                          width15,
                          Container(
                            width: w*0.23,
                            child: Column(
                              children: [
                                cardContainer('Net Amount',provider.totalAmount.isEmpty?'':
                                provider.totalAmount[0].netAmount.toString(),textBigCheck: true,bgColor: Colors.blueAccent),
                                cardContainer('Recvd Amt',provider.totalAmount.isEmpty?'':
                                provider.totalAmount[0].rcvdAmount.toString()),
                                cardContainer('Balance',provider.totalAmount.isEmpty?'':
                                provider.totalAmount[0].balance.toString()),
                                cardContainer('Item Disc',provider.totalAmount.isEmpty?'':
                                provider.totalAmount[0].itemDisc.toString()),
                                cardContainer('Recvd Curr.',provider.totalAmount.isEmpty?'':
                                provider.totalAmount[0].recvdCurr.toString()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
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
                                controller: provider.barcodeCheck,
                                onTap: (){
                                  provider.activeCtrl = provider.barcodeCheck;
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
                        GridView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                              childAspectRatio: 1.5
                          ),
                          children: [
                            buttonContainer('PRINT', textClr: Colors.white, onTap: (){
                            }),
                            buttonContainer('SUBTOTAL', textClr:Colors.white, onTap: (){}),
                            buttonContainer('REFUND', textClr:Colors.white, onTap: (){}),
                            buttonContainer('EXIT', textClr: Colors.white, onTap: (){}),

                            buttonContainer('7', bgClr: Color(0xfff0f0f0), onTap: (){
                              provider.clickedButton('7');
                            }),
                            buttonContainer('8', bgClr: Color(0xfff0f0f0), onTap: (){
                              provider.clickedButton('8');
                            }),
                            buttonContainer('9', bgClr: Color(0xfff0f0f0), onTap: (){
                              provider.clickedButton('9');
                            }),
                            buttonContainer('QTY', textClr: Colors.white,bgClr: Color(0xff0000ff), onTap: (){}),

                            buttonContainer('4', bgClr: Color(0xfff0f0f0), onTap: (){
                              provider.clickedButton('4');
                            }),
                            buttonContainer('5', bgClr: Color(0xfff0f0f0), onTap: (){
                              provider.clickedButton('5');
                            }),
                            buttonContainer('6', bgClr: Color(0xfff0f0f0), onTap: (){
                              provider.clickedButton('6');
                            }),
                            buttonContainer('CLEAR', textClr: Colors.white,bgClr: Colors.red, onTap: (){
                              provider.activeCtrl.clear();
                            }),

                            buttonContainer('1', bgClr: Color(0xfff0f0f0), onTap: (){
                              provider.clickedButton('1');
                            }),
                            buttonContainer('2', bgClr: Color(0xfff0f0f0), onTap: (){
                              provider.clickedButton('2');
                            }),
                            buttonContainer('3', bgClr: Color(0xfff0f0f0), onTap: (){
                              provider.clickedButton('3');
                            }),
                            buttonContainer('CASH', textClr: Colors.white,bgClr: Colors.green, onTap: (){
                              provider.showMyDialog(context);
                            }),

                            buttonContainer('0', bgClr: Color(0xfff0f0f0), onTap: (){
                              provider.clickedButton('0');
                            }),
                            buttonContainer('.', bgClr: Color(0xfff0f0f0), onTap: (){
                              provider.clickedButton('.');
                            }),
                            buttonContainer('00', bgClr: Color(0xfff0f0f0), onTap: (){
                              provider.clickedButton('00');
                            }),
                            buttonContainer('CARD', textClr: Colors.white, onTap: (){}),
                          ],
                        ),
                        height20,
                        InkWell(
                          onTap: (){

                            if(provider.activeCtrl.text.isNotEmpty){
                              provider.addProduct();
                            }else{
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ConfirmDialog(); // Custom dialog content
                                },
                              );
                            }

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
    );});
  }

  Widget cardContainer(String text,String price, {bool textBigCheck = false,Color bgColor = Colors.blueGrey}){

    final w = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextWidget().customTextB(text),
        Container(
            height: 30,
            width: MediaQuery.of(context).size.width*0.1,
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
