import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/button_widget.dart';

class MainButtons extends StatelessWidget {
  const MainButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ButtonWidget(onTap: () {
          Navigator.pop(context);
        }, btnText: 'CANCEL',width: 150,btnColor: Colors.red.shade300),
        ButtonWidget(onTap: () {
        }, btnText: 'OK',width: 150),
      ],
    );
  }
}
