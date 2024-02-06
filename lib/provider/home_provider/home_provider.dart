import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posapp/provider/home_provider/model/total_price_model.dart';
import 'package:posapp/provider/provider.dart';

class HomeProvider extends ChangeNotifier {

  TextEditingController billCon = TextEditingController();
  TextEditingController amountCstPaid = TextEditingController(text: '0.0');

  TextEditingController amountRcvd = TextEditingController(text: '0.0');

  String billNo = "";
  double totalPrice = 0.0;
  double balanceAmount = 0.0;

  getTotalPrice(List<Map<String, dynamic>> tableData){
    totalPrice = 0;
    for (var element in tableData) {
      totalPrice = totalPrice + element['amount'];
    }
    notifyListeners();
  }

  clickedButton(String num){
    billNo = '$billNo$num';
    billCon.text = billNo;
    notifyListeners();
  }

  List<TotalPriceModel> totalAmount = [];

  getTotalAmount(){
    totalAmount.add(TotalPriceModel(
      subTotal: '10',
      billDisc: '20',
      total: '100',
      taxable: '30',
      vat: '5'));
    notifyListeners();
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