import 'dart:io';

import 'package:docttors_aids/models/AidModel.dart';
import 'package:docttors_aids/models/Equipment.dart';
import 'package:docttors_aids/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'package:flutter/widgets.dart';

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({Key? key}) : super(key: key);

  @override
  _RecordsScreenState createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  List? orders;

  @override
  void initState() {
    getOrd();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List aids = [
      AidModel('Medicine Bandits', 6,
          DateTime.now().toString().substring(0, 11), true),
      AidModel('Blade', 2, DateTime.now().toString().substring(0, 11), false),
      AidModel(
          'Thermometer', 4, DateTime.now().toString().substring(0, 11), false),
      AidModel(
          'Stethoscope', 2, DateTime.now().toString().substring(0, 11), false),
      AidModel('Tongue depressor', 1,
          DateTime.now().toString().substring(0, 11), true),
      AidModel('Tongue depressor', 1,
          DateTime.now().toString().substring(0, 11), true),
      AidModel(
          'Stethoscope', 2, DateTime.now().toString().substring(0, 11), false),
      AidModel('Blade', 2, DateTime.now().toString().substring(0, 11), false),
      AidModel('Tongue depressor', 1,
          DateTime.now().toString().substring(0, 11), true),
    ];
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
        child: orders != null
            ? orders != []
                ? ListView.builder(
                    itemBuilder: (context, pos) {
                      List equipments = [];
                      List eqQantity = [];

                      for (int i = 0;
                          i < orders![pos].equipments.length!;
                          i++) {
                        eqQantity.add(orders![pos].equipments[i].quantity);
                        equipments.add(orders![pos].equipments[i].name);
                      }

                      return InkWell(
                        onTap: () {
                          showAlertDialog(context, equipments, eqQantity,
                              orders![pos].status.toString());
                        },
                        child: ListTile(
                          trailing: Text(orders![pos].status.toString()),
                          leading: Icon(
                            Icons.medical_services,
                            color: Colors.blueAccent.shade700,
                          ),
                          title: Text('$equipments'),
                          subtitle: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Quantity ' + '$eqQantity')),
                              ],
                            ),
                          ),
                          isThreeLine: true,
                        ),
                      );
                    },
                    itemCount: orders!.length,
                  )
                : Container(
                    child: Center(
                      child: Text('There are no equipments available'),
                    ),
                  )
            : Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
      ),
    );
  }

  getOrd() async {
    // String cate = Provider.of<ArticlePrvider>(context, listen: false).category;
    String res =
        await Provider.of<AuthProvider>(context, listen: false).getOrders();
    if (res == 'success') {
      orders = Provider.of<AuthProvider>(context, listen: false).orders;
      print(orders);
      setState(() {});
    } else {
      print(res);
    }
  }

  showAlertDialog(
      BuildContext context, List names, List quantitys, String status) {
    List<Widget> eqTextWidgets = [];
    List<Widget> quantTextWidgets = [];

    for (int i = 0; i < names.length; i++) {
      TextEditingController controller = new TextEditingController();
      eqTextWidgets.add(Padding(
        padding: EdgeInsets.only(bottom: 2.h),
        child: Text(
          names[i],
          style: TextStyle(fontSize: 14.sp),
        ),
      ));
    }

    for (int i = 0; i < quantitys.length; i++) {
      quantTextWidgets.add(Padding(
        padding: EdgeInsets.only(bottom: 2.h),
        child: Text(
          quantitys[i].toString(),
          style: TextStyle(fontSize: 14.sp),
        ),
      ));
    }

    // set up the button
    Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop('dialog');
        });

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text('Request Details'),
      content: Row(
        children: [
          SizedBox(
            width: 15.sp,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: eqTextWidgets,
          ),
          Spacer(),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: quantTextWidgets,
          ),
          SizedBox(
            width: 15.sp,
          ),
        ],
      ),
      actions: [
        Align(
            child: Row(
          children: [
            SizedBox(
              width: 10.h,
            ),
            Text(
              'status: ',
              style: TextStyle(fontSize: 18, color: Colors.blueGrey.shade500),
            ),
            Text(
              '$status',
              style: TextStyle(fontSize: 18, color: Colors.blueGrey.shade500),
            ),
            SizedBox(
              width: 10.h,
            ),
          ],
        )),
        SizedBox(
          height: 5.h,
        ),
        Align(child: okButton),
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
