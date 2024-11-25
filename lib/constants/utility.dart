import 'package:flutter/cupertino.dart';
import 'package:toastification/toastification.dart';

showToast(BuildContext context,type,text) {
  if (context.mounted) {
    toastification.show(
        context: context, // optional if you use ToastificationWrapper
        title: Text(type),
        autoCloseDuration: const Duration(seconds: 5),
        description: Text(text)
    );
  }
}