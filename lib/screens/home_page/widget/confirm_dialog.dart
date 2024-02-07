import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posapp/constants/sized_box.dart';
import 'package:provider/provider.dart';

import '../../../provider/home_provider/home_provider.dart';
import '../../../widgets/text_style.dart';
import '../../../widgets/textfield.dart';
import 'custom_container.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    List<Map<String,String>> listsData = [
      {'AED':'1'}, {'\$':'5'}, {'SR':'6'}, {'QAR':'1'}, {'OMR':"2"}, {'KWD':'3'}
    ];

    final ts = CustomTextWidget();

    return Consumer<HomeProvider>(builder: (context, provider, child) {


      return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        width: 1300,
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
                            TextStyles().onlyNumberTFFF(cont: provider.amountRcvd,context: context),
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
                            TextStyles().onlyNumberTFFF(cont: provider.amountRcvd,context: context),
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
                                child: Text('Received By Cash'),
                              ),
                            ),
                            TextStyles().onlyNumberTFFF(cont: provider.amountRcvd,context: context),
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
                                child: Text(''),
                              ),
                            ),
                            TextStyles().onlyNumberTFFF(cont: provider.amountRcvd,context: context),
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
                            TextStyles().onlyNumberTFFF(cont: provider.amountRcvd,context: context),
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
                            TextStyles().onlyNumberTFFF(cont: provider.amountRcvd,context: context),
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
                            TextStyles().onlyNumberTFFF(cont: provider.amountRcvd,context: context),
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
                            TextStyles().onlyNumberTFFF(cont: provider.amountRcvd,context: context),
                          ],
                        ),
                      ),
                    ],
                  ),
                  height30,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 300,
                            width: 300,
                            child: GridView(
                            physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 1.5
                                    ),
                                    children: [
                                      buttonContainer('7', bgClr: Color(0xfff0f0f0), onTap: (){
                            // provider.clickedButton('7');
                                      }),
                                      buttonContainer('8', bgClr: Color(0xfff0f0f0), onTap: (){
                            // provider.clickedButton('8');
                                      }),
                                      buttonContainer('9', bgClr: Color(0xfff0f0f0), onTap: (){
                            // provider.clickedButton('9');
                                      }),
                                      buttonContainer('4', bgClr: Color(0xfff0f0f0), onTap: (){
                            // provider.clickedButton('4');
                                      }),
                                      buttonContainer('5', bgClr: Color(0xfff0f0f0), onTap: (){
                            // provider.clickedButton('5');
                                      }),
                                      buttonContainer('6', bgClr: Color(0xfff0f0f0), onTap: (){
                            // provider.clickedButton('6');
                                      }),
                                      buttonContainer('1', bgClr: Color(0xfff0f0f0), onTap: (){
                                        // provider.clickedButton('1');
                                      }),
                                      buttonContainer('2', bgClr: Color(0xfff0f0f0), onTap: (){
                                        // provider.clickedButton('2');
                                      }),
                                      buttonContainer('3', bgClr: Color(0xfff0f0f0), onTap: (){
                                        // provider.clickedButton('3');
                                      }),
                                      buttonContainer('0', bgClr: Color(0xfff0f0f0), onTap: (){
                                        // provider.clickedButton('1');
                                      }),
                                      buttonContainer('.', bgClr: Color(0xfff0f0f0), onTap: (){
                                        // provider.clickedButton('2');
                                      }),
                                      buttonContainer('00', bgClr: Color(0xfff0f0f0), onTap: (){
                                        // provider.clickedButton('3');
                                      }),

                                    ]),
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: 150,
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade300,
                                    borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2, //                   <--- border width here
                                    ),
                                  ),
                                  height: 60,
                                  child: Center(child: CustomTextWidget().customTextB('CANCEL',color: Colors.white)),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                },
                                child: Container(
                                  width: 150,
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
                                  child: Center(child: CustomTextWidget().customTextB('OK',color: Colors.white)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 30,
                            width: w>500 ?550/2.5:w / 4,
                            decoration: BoxDecoration(
                                color: Colors.grey,),
                            child: Center(child: Text('CASH'))
                          ),
                          height10,
                          Container(
                              height: 30,
                              width: w>500 ?550/2.5:w / 4,
                              decoration: BoxDecoration(
                                  color: Colors.grey,),
                              child: Center(child: Text('CARD'))
                          ),
                          height10,
                          Container(
                              height: 30,
                              width: w>500 ?550/2.5:w / 4,
                              decoration: BoxDecoration(
                                  color: Colors.grey),
                              child: Center(child: Text('CASH - CARD'))
                          ),
                        ],
                      ),
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
                  // borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.blue.shade50,width: 5,)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
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
                        Container(
                          height: 40,
                          color: Colors.grey.shade200,
                          child: Center(
                            child: ts.customTextBL('13.50'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 400,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Currency'),
                              Text('Rate'),
                            ],
                          ),
                        ),
                        Divider(),
                        ListView.builder(
                          itemCount: listsData.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {

                            String currency = listsData[index].keys.first;
                            String value = listsData[index].values.first;

                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(currency),
                                    Text(value),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  height30,
                  Container(
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
                    width: 200,
                    child: Center(child: CustomTextWidget().customTextB('ENTER',color: Colors.white)),
                  ),
                  // Add your custom content here
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
    );}}