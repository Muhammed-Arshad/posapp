import 'package:flutter/material.dart';

class LabeledTextField extends StatelessWidget {
  final String label;
  // final VoidCallback onTap;
  final TextEditingController ctrl;

  const LabeledTextField({
    Key? key,
    // required this.onTap,
    required this.ctrl,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$label: ',style: TextStyle(
            fontSize: 20,
          ),),
          // width10,
          SizedBox(
            width: 300,
            child: TextField(
              // readOnly: true,
              decoration: InputDecoration(
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
            ),
          ),
        ],
      ),
    );
  }
}