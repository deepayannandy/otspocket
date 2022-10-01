import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../auth/login.dart';
import '../models/usermodel.dart';
import 'construction.dart';
import 'contact.dart';

class MyDrower extends StatefulWidget {
  @override
  _MyDrower createState() => _MyDrower();
}

class _MyDrower extends State<MyDrower> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xff45ac72),
        child: ListView(
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                margin: EdgeInsets.all(0),
                accountName: Text(
                  loggedInUser.fullname.toString(),
                ),
                accountEmail: Text(loggedInUser.email.toString()),
                currentAccountPicture:
                    Image.asset("asset/images/userlogo.jpeg"),
              ),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.qrcode,
                color: Colors.white,
              ),
              title: Text(
                "Show QR",
                textScaleFactor: 1.2,
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Users Qr Code'),
                    content: QrImage(
                      data: "http://3.95.56.247:8080/employee/" +
                          loggedInUser.uniqueid.toString(),
                      size: 250,
                      embeddedImage: AssetImage(
                        "assets/images/userlogo.png",
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text(
                          'Done',
                          textScaleFactor: 1,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.hand_draw,
                color: Colors.white,
              ),
              title: Text(
                "About Us",
                textScaleFactor: 1.2,
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => underConst()));
              },
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.person,
                color: Colors.white,
              ),
              title: Text(
                "Contact Us",
                textScaleFactor: 1.2,
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactUs()));
              },
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.backward,
                color: Colors.white,
              ),
              title: Text(
                "Log Out",
                textScaleFactor: 1.2,
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Are you sure you want to Logout!'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () {
                          logout(context);
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                );

                // title:Text("Logout") ,
                // content:Text("Are you sure you want to logout?"),
                // actions: [
                //   ElevatedButton(onPressed: (){
                //   Navigator.pop(context);
                //   },child: Text("No")),
                //   ElevatedButton(onPressed: (){
                //
                //   }, child: Text("Yes"))
                // ],
              },
            ),
            Container(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Column(
                      children: <Widget>[
                        // Divider(),
                        ListTile(
                            // leading: Icon(
                            //   CupertinoIcons.heart,
                            //   color: Colors.white,
                            // ),
                            title: Text(
                          "Powered by OTS-Pocket",
                          textScaleFactor: 1,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        )),
                      ],
                    ))),
          ],
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
  }
}

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Simple Alert"),
    content: Text("This is an alert message."),
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
