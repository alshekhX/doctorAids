import 'package:avatar_glow/avatar_glow.dart';
import 'package:docttors_aids/providers/authProvider.dart';
import 'package:docttors_aids/screens/login_screen/LoginScreen.dart';
import 'package:docttors_aids/screens/login_screen/createOrder_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 5.h,
            ),
            ListTile(
              leading: Icon(Icons.question_answer),
              title: Text('About Us'),
            ),
            ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.logout),
              onTap: () {
                pushNewScreen(context, screen: Login(),withNavBar: false,pageTransitionAnimation: PageTransitionAnimation.fade);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
                backgroundColor: Colors.white,
                      iconTheme: IconThemeData(color: Colors.black),


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
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 6),
                            color: Colors.black.withOpacity(.1))
                      ],
                      border: Border.all(
                        width: 2.0,
                        // assign the color to the border color
                        color: Colors.blueAccent.shade700,
                      ),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5.w,
                        ),
                        Container(
                            width: 60.w,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Welcome ',
                                  style: TextStyle(fontSize: 32.sp),
                                ),
                                Row(
                                  children: [
                                    Text('Dr ',
                                        style: TextStyle(
                                            fontSize: 24.sp,
                                            color: Colors.blueAccent.shade700)),
                                    Text(
                                        Provider.of<AuthProvider>(context)
                                            .user!
                                            .name!,
                                        style: TextStyle(fontSize: 26.sp))
                                  ],
                                )
                              ],
                            )),
                        Container(
                          width: 30.w,
                          child: CircleAvatar(
                            radius: 50,
                            foregroundImage: AssetImage('images/doc.png'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                    alignment: Alignment.center,
                    child: AvatarGlow(
                      endRadius: 110.0,
                      glowColor: Colors.redAccent.shade700,
                      child: Material(
                        shape: CircleBorder(),
                        child: InkWell(
                          onTap: () {
                            pushNewScreen(context,
                                screen: OrderCreation(),
                                withNavBar: false,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.scale);
                          },
                          child: CircleAvatar(
                            foregroundColor: Colors.white,
                            child: Icon(
                              Icons.medical_services,
                              size: 90.sp,
                            ),
                            radius: 80,
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
