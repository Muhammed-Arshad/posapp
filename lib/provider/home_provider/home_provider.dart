import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posapp/provider/home_provider/model/total_price_model.dart';
import 'package:posapp/provider/provider.dart';

class HomeProvider extends ChangeNotifier {

  TextEditingController billCon = TextEditingController();
  TextEditingController amountCstPaid = TextEditingController(text: '0.0');

  TextEditingController barcodeCheck = TextEditingController();
  late TextEditingController activeCtrl = barcodeCheck;

  TextEditingController amountRcvdCtrl = TextEditingController(text: '');
  FocusNode amountRcvdFocus = FocusNode();
  TextEditingController amountChangeCtrl = TextEditingController(text: '');
  TextEditingController rcvdByCashCtrl = TextEditingController(text: '');
  TextEditingController currencyCtrl = TextEditingController(text: 'AED');
  TextEditingController rateCtrl = TextEditingController(text: '1');
  TextEditingController rcvdCurrCtrl = TextEditingController(text: '');
  TextEditingController rcvdByCardCtrl = TextEditingController(text: '');
  TextEditingController sampleCtrl = TextEditingController(text: '');


  List<Map<String, dynamic>> tableData = [
    {'No': 1, 'itemCode': 'A001', 'itemName': 'Item 1', 'Quantity': 1, 'amount': 20, 'totalAmount': 0},
    {'No': 2, 'itemCode': 'A002', 'itemName': 'Item 2', 'Quantity': 1, 'amount': 30, 'totalAmount': 0},
    {'No': 3, 'itemCode': 'A003', 'itemName': 'Item 2', 'Quantity': 1, 'amount': 35, 'totalAmount': 0},
    // {'No': 4, 'itemCode': 'A004', 'itemName': 'Item 2', 'Quantity': 1, 'amount': 46.5, 'totalAmount': 0},
    // {'No': 5, 'itemCode': 'A005', 'itemName': 'Item 2', 'Quantity': 1, 'amount': 30, 'totalAmount': 0},
    // {'No': 5, 'itemCode': 'A005', 'itemName': 'Item 2', 'Quantity': 1, 'amount': 30, 'totalAmount': 0},
    // {'No': 5, 'itemCode': 'A005', 'itemName': 'Item 2', 'Quantity': 1, 'amount': 30, 'totalAmount': 0},
    // {'No': 5, 'itemCode': 'A005', 'itemName': 'Item 2', 'Quantity': 1, 'amount': 30, 'totalAmount': 0},
    // {'No': 5, 'itemCode': 'A005', 'itemName': 'Item 2', 'Quantity': 1, 'amount': 30, 'totalAmount': 0},
    // {'No': 5, 'itemCode': 'A005', 'itemName': 'Item 2', 'Quantity': 1, 'amount': 30, 'totalAmount': 0},
    // {'No': 5, 'itemCode': 'A005', 'itemName': 'Item 2', 'Quantity': 1, 'amount': 30, 'totalAmount': 0},
    // {'No': 5, 'itemCode': 'A005', 'itemName': 'Item 2', 'Quantity': 1, 'amount': 30, 'totalAmount': 0},
    // {'No': 5, 'itemCode': 'A005', 'itemName': 'Item 2', 'Quantity': 1, 'amount': 30, 'totalAmount': 0},
    // {'No': 5, 'itemCode': 'A005', 'itemName': 'Item 2', 'Quantity': 1, 'amount': 30, 'totalAmount': 0},
    // {'No': 5, 'itemCode': 'A005', 'itemName': 'Item 2', 'Quantity': 1, 'amount': 30, 'totalAmount': 0},
    // {'No': 5, 'itemCode': 'A005', 'itemName': 'Item 2', 'Quantity': 1, 'amount': 30, 'totalAmount': 0},
    // Add more rows as needed
  ];

  String billNo = "";
  double totalPrice = 0.0;
  double balanceAmount = 0.0;

  addProduct(){
    tableData.add({'No': 1, 'itemCode': 'A001', 'itemName': 'Item 1', 'Quantity': 1, 'amount': 20, 'totalAmount': 0});
    getPriceTotal(tableData);
  }

  getTotalPrice(List<Map<String, dynamic>> tableData){
    totalPrice = 0;
    for (var element in tableData) {
      totalPrice = totalPrice + element['amount'];
    }
    notifyListeners();
  }

  clickedButton(String num){
    // billNo = '$billNo$num';
    // billCon.text = billNo;
    activeCtrl.text = activeCtrl.text + num;
    notifyListeners();
  }

  List<TotalPriceModel> totalAmount = [];

  getTotalAmount(){

    totalAmount.add(TotalPriceModel(
      subTotal: '0.00',
      billDisc: '0.00',
      total: '0.00',
      taxable: '0.00',
      vat: '0.00',
      netAmount: '0.00',
      rcvdAmount: '0.00',
      balance: '0.00',
      itemDisc: '0.00',
      recvdCurr: '0.00'));

    // activeCtrl.addListener(getConfirmDialogBoxData);

    notifyListeners();
  }

  getPriceTotal(List<Map<String, dynamic>> tableData){
    var total = 0.0;
    for(var e in tableData){
      total = total + (e['amount'] * e['Quantity']);
    }

    totalAmount[0].subTotal = total.toString();
    totalAmount[0].netAmount = total.toString();
    totalAmount[0].total = total.toString();
    notifyListeners();
  }

  getConfirmDialogBoxData(){

    print('ARSHAD');
    rcvdByCashCtrl.text = activeCtrl.text;
    amountRcvdCtrl.text = activeCtrl.text;

    if(activeCtrl.text != null && activeCtrl.text != ""){

      double rcvdAmt = double.parse(activeCtrl.text);
      double totalAmt = double.parse(totalAmount[0].netAmount!);

      amountChangeCtrl.text = (rcvdAmt - totalAmt).toString();
    }

    notifyListeners();

  }

  clearAllCtrl(){
    amountRcvdCtrl.clear();
    amountChangeCtrl.clear();
    rcvdByCashCtrl.clear();
    activeCtrl.text = "";
    // TextEditingController currencyCtrl = TextEditingController(text: '');
    // TextEditingController rateCtrl = TextEditingController(text: '');
    // TextEditingController rcvdCurrCtrl = TextEditingController(text: '');
    // TextEditingController rcvdByCardCtrl = TextEditingController(text: '');
    // TextEditingController sampleCtrl = TextEditingController(text: '');
  }

  Future<void> showMyDialog(BuildContext context) async {

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Amount'),
          content: SizedBox(
            height: 200,
            child: Column(
              children: [
                TextField(
                  controller: amountCstPaid,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        amountCstPaid.clear();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              child: const Text('Close', style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () {
                // Process the entered amount here
                double enteredAmount = double.parse(amountCstPaid.text);
                print('Entered Amount: $enteredAmount');
                balanceAmount = enteredAmount - totalPrice;
                notifyListeners();
                Navigator.of(context).pop(); // Close the dialog
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              child: const Text('Enter', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }


}