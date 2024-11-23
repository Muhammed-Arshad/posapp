
import 'package:flutter/material.dart';
import 'package:posapp/screens/home/home_page.dart';

import '../../constants/colors.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool isRegister = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool _isPasswordHidden = true;
  final bool _isUserLogin = true;


  @override
  Widget build(BuildContext context) {

    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Login",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Center(
              child: Container(
                width: screenWidth * 0.38,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        SizedBox(height: 40),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xfff6f7f9),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(width: 1,color: AppColors.primary),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(width: 1,color: Colors.transparent),
                                ),
                                suffixIcon:Icon(Icons.email),
                                suffixIconColor: WidgetStateColor.resolveWith((states) =>
                                states.contains(WidgetState.focused)
                                    ? AppColors.primary
                                    : Colors.grey),
                                labelText: 'Email',
                                hintText: 'Enter valid email'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email address';
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 20, bottom: 0),
                          //padding: EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: _isPasswordHidden,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xfff6f7f9),

                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(width: 1,color: AppColors.primary),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(width: 1,color: Colors.transparent),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                                  ),
                                  onPressed: () {

                                    setState(() {
                                      _isPasswordHidden = !_isPasswordHidden;
                                    });
                                  },
                                ),
                                suffixIconColor: WidgetStateColor.resolveWith((states) =>
                                states.contains(WidgetState.focused)
                                    ? AppColors.primary
                                    : Colors.grey),
                                labelText: 'Password',
                                hintText: 'Enter secure password'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your Password';
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 40),
                        Container(
                          height: 50,
                          width: 250,
                          decoration: BoxDecoration(
                              // gradient: const LinearGradient(
                              //   begin: Alignment.topLeft,
                              //   end: Alignment.bottomRight,
                              //   stops: [0.1, 0.5, 0.8, 0.9],
                              //   colors: [
                              //     AppColors.grad1,
                              //     AppColors.grad2,
                              //     AppColors.grad3,
                              //     AppColors.grad4,
                              //
                              //   ],
                              // ),
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(30)),
                          child: TextButton(
                            onPressed: () {
                              // if (formKey.currentState!.validate()) {
                              //   if (isRegister) {
                              //   }else {
                              //   }
                              // }

                              Navigator.push(context, MaterialPageRoute(builder:
                                  (BuildContext context) => HomePage()));
                            },
                            child: Text(
                              isRegister ? 'Register' : 'Login',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: (){
                            //TODO FORGOT PASSWORD SCREEN GOES HERE
                          },
                          child: Text(
                            'Forgot Password',
                            style: TextStyle(color: AppColors.primary, fontSize: 15),
                          ),
                        ),

                        SizedBox(height: 20),

                        SizedBox(
                          height: 130,
                        ),
                        !_isUserLogin ? InkWell(
                            onTap: () {
                              isRegister = !isRegister;
                              setState(() {});
                            },
                            child: Text('New User? Create Account')) : SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}

