import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/styles.dart';


class TextStyles {


  onlyNumberTFFF({
    required TextEditingController cont,
    BuildContext? context
  }) {

    return TextFormField(
      controller: cont,
      onChanged: (val){


      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.blueGrey.shade200,
        // Remove the underline here
        hintText: '0',
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 9),
      ),
      keyboardType: TextInputType.numberWithOptions(decimal: false), // Set the keyboard type to number
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(3),
        FilteringTextInputFormatter.digitsOnly, // Allow only digits
      ],
      scrollPadding: EdgeInsets.zero,
      style: Styles().normalS(
          fontS: 13,
          fontW: FontWeight.w700,
          color: Colors.black,
          fontF: "Poppins",
          fontStl:
          FontStyle.normal),
      textAlign: TextAlign.center,
    );
  }
}

