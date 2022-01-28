import 'dart:io';

import 'package:docttors_aids/models/Order.dart';
import 'package:docttors_aids/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class OrderCreation extends StatefulWidget {
  const OrderCreation({Key? key}) : super(key: key);

  @override
  _OrderCreationState createState() => _OrderCreationState();
}

class _OrderCreationState extends State<OrderCreation> {
  int formNumber = 1;
  List controllers = [];
  List idValues = [];
  List equipments = [];

  String droDownValue = 'إختر أداة';
  controllerGenerator() {
    for (int i = 0; i < formNumber; i++) {
      TextEditingController controller = new TextEditingController();
      controllers.add(controller);
    }
    print(controllers.length);

    for (int i = 0; i < formNumber; i++) {
      String? value;
      idValues.add(value);
    }
  }

  getEqt() async {
    // String cate = Provider.of<ArticlePrvider>(context, listen: false).category;
    String res =
        await Provider.of<AuthProvider>(context, listen: false).getEquipments();
    if (res == 'success') {
      equipments =
          Provider.of<AuthProvider>(context, listen: false).equipments!;
      print(equipments);
      setState(() {});
    } else {
      print(res);
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    controllerGenerator();
    textFieldGen();

    // TODO: implement initState
    super.initState();
  }

  List<Widget> textFields = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
          child: equipments != []
              ? SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5.h,
                        ),
                        Column(
                          children: textFields,
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              width: 30.w,
                              child: ElevatedButton(
                                child: Text(
                                  'Add',
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary:
                                      Colors.blueAccent.shade700, // background
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  // foreground
                                ),
                                onPressed: () {
                                  formNumber++;
                                  TextEditingController controller =
                                      new TextEditingController();
                                  String? dropvalue;
                                  idValues.add(dropvalue);
                                  controllers.add(controller);
                                  textFields.add(Row(
                                    children: [
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 1.h),
                                        child: Container(
                                          width: 40.w,
                                          child: DropdownButton(
                                            onTap: () {},
                                            elevation: 0,
                                            value:
                                                idValues[idValues.length - 1],
                                            hint: Text(
                                              "Choose An Equipment",
                                              style: TextStyle(fontSize: 10.sp),
                                            ),
                                            items: equipments.map((data) {
                                              return DropdownMenuItem(
                                                value: data.id,
                                                child: new Text(
                                                  data.name,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (newvalue) {
                                              print(newvalue);
                                              idValues[idValues.length - 1] =
                                                  newvalue!;
                                              //enable html controller to solve focus issues

                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 1.h),
                                        child: Container(
                                          width: 30.w,
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'empty field';
                                              }
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              hintText: 'Quantity',
                                              hintStyle:
                                                  TextStyle(fontSize: 12.sp),

                                              isDense: true,
                                              // Added this

                                              border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.white,
                                                    width: 2.0),
                                                borderRadius: BorderRadius.zero,
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .blueAccent.shade700,
                                                    width: 2.0),
                                                borderRadius: BorderRadius.zero,
                                              ),
                                            ),
                                            controller: controllers[
                                                controllers.length - 1],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                    ],
                                  ));

                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () async {
                              CustomProgressDialog progressDialog =
                                  CustomProgressDialog(context, blur: 5);
                              progressDialog
                                  .setLoadingWidget(CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(
                                Colors.blueAccent.shade700,
                              )));

                              if (_formKey.currentState!.validate()) {
                                String internetConn =
                                    await _checkInternetConnection();

                                if (internetConn == 'false') {
                                  showAlertDialog(context, 'Network Error',
                                      'Make sure your internet connection is working correctly ');
                                  print('wrong');
                                } else {
                                  try {
                                    progressDialog.show();

                                    List orders = [];
                                    for (int i = 0; i < formNumber; i++) {
                                      print(idValues[i]);
                                      print(controllers[i].text);

                                      orders.add(new Order(
                                              idValues[i], controllers[i].text)
                                          .toMap());
                                      print(orders);
                                    }

                                    String res =
                                        await Provider.of<AuthProvider>(context,
                                                listen: false)
                                            .addAidsOrder(
                                                orders,
                                                Provider.of<AuthProvider>(
                                                        context,
                                                        listen: false)
                                                    .user!
                                                    .id!);

                                    if (res == 'success') {
                                      progressDialog.dismiss();

                                      await showAlertDialog(context, 'Success',
                                          'Your request is saved ');
                                      // SharedPreferences prefs =
                                      //     await SharedPreferences.getInstance();

                                      // prefs.setString(
                                      //     'userToken',
                                      //     Provider.of<AuthProvider>(context, listen: false)
                                      //         .token);

                                    } else if (res == 'f') {
                                      progressDialog.dismiss();
                                      await showAlertDialog(context, 'Error',
                                          'Make sure there is no empty fields ');
                                      print('wrong in re');
                                    } else {
                                      progressDialog.dismiss();
                                      await showAlertDialog(
                                          context,
                                          'Network Error',
                                          'Make sure your internet connection is working correctly ');
                                      // showTopSnackBar(

                                    }
                                  } catch (e) {
                                    progressDialog.dismiss();
                                    await showAlertDialog(context, 'Error',
                                        'Make sure there is no empty fields ');
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
                            },
                            child: Text(
                              'Send Request',
                              style: TextStyle(fontSize: 20.sp),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blueAccent.shade700, // background
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(),
                              // foreground
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )),
    );
  }

  void textFieldGen() async {
    await getEqt();

    for (int i = 0; i < formNumber; i++) {
      textFields.add(Row(
        children: [
          SizedBox(
            width: 5.w,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: Container(
              width: 40.w,
              child: DropdownButton(
                onTap: () {},
                elevation: 0,
                value: idValues[i],
                hint: Text(
                  "Choose An Equipment",
                  style: TextStyle(fontSize: 10.sp),
                ),
                items: equipments.map((data) {
                  return DropdownMenuItem(
                    value: data.id,
                    child: new Text(
                      data.name,
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
                onChanged: (newvalue) {
                    idValues[idValues.length - 1] =
                                                  newvalue!;
                  print(equipments[i].name);
                  //enable html controller to solve focus issues

                  setState(() {});
                },
              ),
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: Container(
              width: 30.w,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'empty field';
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Quantity',
                  hintStyle: TextStyle(fontSize: 12.sp),

                  isDense: true,
                  // Added this

                  border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.zero,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blueAccent.shade700, width: 2.0),
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                controller: controllers[i],
              ),
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
        ],
      ));
    }
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
}
