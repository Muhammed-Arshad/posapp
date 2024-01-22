import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posapp/provider/home_provider/home_provider.dart';
import 'package:posapp/provider/provider.dart';
import 'package:provider/provider.dart';

class CustomTextField {
  normalTFF({
    required String labelText,
    required TextEditingController cont,
  }) {
    return Container(

      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff888888), width: 1.7),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: TextFormField(
        controller: cont,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          labelText: labelText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}