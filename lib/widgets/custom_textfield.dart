import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  // final VoidCallback onTap;
  final TextEditingController ctrl;

  const CustomTextField({
    Key? key,
    required this.labelText,
    // required this.onTap,
    required this.ctrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(fontSize: 16, color: Colors.grey[700]),
        // suffixIcon: Icon(icon, color: Colors.grey[600]),
        filled: true,
        fillColor: Colors.grey[100],
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      ),
      // onTap: onTap,
      controller: ctrl,
    );
  }
}