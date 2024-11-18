import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrencyList extends StatelessWidget {
  CurrencyList({super.key});

  final List<Map<String,String>> listsData = [
    {'AED':'1'}, {'\$':'5'}, {'SR':'6'}, {'QAR':'1'}, {'OMR':"2"}, {'KWD':'3'}
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
