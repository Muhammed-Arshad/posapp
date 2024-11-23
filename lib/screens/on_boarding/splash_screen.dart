import 'dart:async';
import 'package:flutter/material.dart';
import '../home/home_page.dart';


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
