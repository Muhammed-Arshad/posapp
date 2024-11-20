import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/textfield.dart';

class PriceTextField extends StatelessWidget {
  final bool readOnly;
  final TextEditingController ctrl;
  final FocusNode? focusNode;
  final String title;
  final Color headerClr;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  const PriceTextField({super.key,
    required this.ctrl,
    this.focusNode,
    required this.title,
    this.headerClr = Colors.green,
    this.onTap,
    this.onChanged,
    this.readOnly = false});

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;

    return Container(
      height: 69,
      width: w>500 ?550/4:w / 5,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Container(
            color: headerClr,
            child: Center(
              child: Text(title),
            ),
          ),
          TextStyles().onlyNumberTFFF(
            readOnly: readOnly,
            onTap: onTap,
              onChanged: onChanged,
              cont: ctrl,
              context: context,
              focusNode: focusNode),
        ],
      ),
    );
  }
}
