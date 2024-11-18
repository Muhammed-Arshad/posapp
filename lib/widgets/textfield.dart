import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../constants/styles.dart';
import '../provider/home_provider/home_provider.dart';


class TextStyles {

  onlyNumberTFFF({
    bool readOnly = false,
    VoidCallback? onTap,
    ValueChanged<String>? onChanged,
    required TextEditingController cont,
    BuildContext? context,
    FocusNode? focusNode,
  }) {

    return TextFormField(
      readOnly: readOnly,
      controller: cont,
      focusNode: focusNode,
      onTap: onTap,
      onTapOutside: (event) {
        // FocusScope.of(context).unfocus();
        focusNode?.requestFocus();
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.blueGrey.shade200,
        // Remove the underline here
        hintText: '0',
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 9),
      ),
      keyboardType: TextInputType.numberWithOptions(decimal: true), // Set the keyboard type to number
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(5),
        FilteringTextInputFormatter.digitsOnly, // Allow only digits
      ],
      scrollPadding: EdgeInsets.zero,
      style: Styles().normalS(
          fontS: 16,
          fontW: FontWeight.w700,
          color: Colors.black,
          fontF: "Poppins",
          fontStl:
          FontStyle.normal),
      textAlign: TextAlign.center,
    );
  }
}

