import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posapp/screens/home_page/home_page.dart';
import 'package:provider/provider.dart';

import '../../provider/home_provider/home_provider.dart';
import '../login/login_page.dart';
import '../product/products_table.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder:
          // (BuildContext context) => ProductTableView()));
          (BuildContext context) => HomePage()));
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('ARR - POS',style: TextStyle(fontSize: 30),),
      ),
    );
  }
}
