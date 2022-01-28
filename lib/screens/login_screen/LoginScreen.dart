import 'dart:io';

import 'package:docttors_aids/main.dart';
import 'package:docttors_aids/providers/authProvider.dart';
import 'package:docttors_aids/screens/bottom_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ndialog/ndialog.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  // This function is triggered when the floating button is pressed
  Future<String> _checkInternetConnection() async {
    try {
      final response = await InternetAddress.lookup('www.google.com');
      if (response.isNotEmpty) {
        setState(() {});
        return 'success';
      }
      return 'success';
    } on SocketException catch (err) {
      return 'false';
    }
  }

  TextEditingController phoneC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  bool? _isConnected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,

        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Dr',
              style:
                  TextStyle(color: Colors.blueAccent.shade700, fontSize: 24.sp),
            ),
            Text(
              'aids',
              style:
                  TextStyle(color: Colors.redAccent.shade700, fontSize: 24.sp),
            ),
          ],
        ),
      ),
  
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 15.h,
              ),
              Center(
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 32.sp),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                width: 75.w,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your phone number';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
    
                    isDense: true,
                    // Added this
    
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blueAccent.shade700, width: 2.0),
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  controller: phoneC,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                width: 75.w,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Password',
    
                    isDense: true,
                    // Added this
    
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blueAccent.shade700, width: 2.0),
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  controller: passwordC,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                width: 40.w,
                height: 8.h,
                child: ElevatedButton(
                  child: Text(
                    'Log In',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent.shade700, // background
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    // foreground
                  ),
                  onPressed: () async {
                    CustomProgressDialog progressDialog = CustomProgressDialog(context,blur: 5);
      progressDialog.setLoadingWidget(CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.blueAccent.shade700,)));
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => BottomNavNar()));
                    if (_formKey.currentState!.validate()) {
                      String internetConn = await _checkInternetConnection();
    
                      if (internetConn == 'false') {
                        showAlertDialog(context, 'Network Error',
                            'Make sure your internet connection is working correctly ');
                        print('wrong');
                      } else {
                        try {
      
      progressDialog.show();
                          String res = await Provider.of<AuthProvider>(context,
                                  listen: false)
                              .signIN(phoneC.text, passwordC.text);
                          print(res);
                          if (res == 'success') {
                              progressDialog.dismiss();
                            // SharedPreferences prefs =
                            //     await SharedPreferences.getInstance();
    
                            // prefs.setString(
                            //     'userToken',
                            //     Provider.of<AuthProvider>(context, listen: false)
                            //         .token);
    
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => BottomNavBAr()),
                                (route) => false);
                          } else if (res == 'f') {
      progressDialog.dismiss();                          await showAlertDialog(context, 'Invalid Credintials',
                                'Make sure phone number and password are correct');
                            print('wrong in re');
                          } else {
      progressDialog.dismiss(); 
                            await showAlertDialog(context, 'Network Error',
                                'Make sure your internet connection is working correctly ');
                            // showTopSnackBar(
    
                          }
                        } catch (e) {
      progressDialog.dismiss(); 
                          await showAlertDialog(context, 'Network Error',
                              'Make sure your internet connection is working correctly ');
                          // showTopSnackBar(
                          //   context,
                          //   CustomSnackBar.error(
                          //     message: "$e",
                          //   ),
                          // );
                          print('$e');
                        }
                      }
                    }
    
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => BottomNavBAr()));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, String title, String message) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
