import 'dart:developer';
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otspocket/models/usermodel.dart';
import 'package:url_launcher/url_launcher.dart';

List<List<String>> services = [
  [
    "Bronze Pack",
    "asset/images/30.png",
    "Valitity: 3 Monthes ○ Balance: 120 Min",
    "Helo mini Machine + free shipping +3 Months Valitity",
    "25000",
    "0xffCD7F32"
  ],
  [
    "Silver Pack",
    "asset/images/50.png",
    "Valitity: 6 Monthes ○ Balance: 240 Min",
    "Helo mini Machine + free shipping +6 Months Valitity",
    "35000",
    "0xffC0C0C0"
  ],
  [
    "Gold Pack",
    "asset/images/70.png",
    "Valitity: 6 Monthes ○ Balance: 360 Min",
    "Helo mini Machine + free shipping +6 Months Valitity",
    "55000",
    "0xffFFD700"
  ]
];

class noKYC extends StatelessWidget {
  final UserModel activeuser;
  const noKYC({required this.activeuser}) : super();
  @override
  Widget build(BuildContext context) {
    //Fluttertoast.showToast(msg: services.length.toString());
    // Fluttertoast.showToast(msg: services[0][1]);
    return SingleChildScrollView(
      child: Column(children: [
        Padding(padding: const EdgeInsets.all(8.0), child: credit()),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("asset/images/add.png"),
        ),
        tiles(services[0]),
        tiles(services[1]),
        tiles(services[2]),
        SizedBox(
          height: 20,
        ),
      ]),
    );
  }

  credit() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("User Name",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Colors.black54,
                    )),
                Spacer(),
                Text("Balance",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Colors.black54,
                    )),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(activeuser.fullname.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xff13a693),
                    )),
                Spacer(),
                Text("8 Hr",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 24,
                      color: Color(0xff13a693),
                    )),
              ],
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: Color(0xff13a693), //                   <--- border color
          width: 2.0,
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
          ),
        ],
      ),
    );
  }

  tiles(service) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 200,
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: Color(int.parse(service[5])),
                  )),
            ),
            Positioned(
              top: 10,
              left: 20,
              child: Image.asset(
                "asset/images/userlogo.png",
                color: Colors.black12,
              ),
              width: 200,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                        Colors.black.withOpacity(.65),
                        Colors.transparent
                      ])),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(service[1]),
              width: 60,
            ),
            Positioned(
              top: 0,
              right: 0,
              child: MaterialButton(
                onPressed: () {
                  Fluttertoast.showToast(msg: "KYC not complete!");
                },
                color: Color(0xff54ccc4),
                textColor: Colors.white,
                child: Row(
                  children: [
                    Text("Book Now "),
                    Icon(
                      Icons.arrow_forward,
                      size: 18,
                    ),
                  ],
                ),
                padding: EdgeInsets.all(5),
                //shape: borde,
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(service[0],
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Text(service[2],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Text(service[3],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Rs. " + service[4],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                )),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "asset/images/logo.png",
                color: Colors.black87,
              ),
              width: 145,
            ),
          ],
        ),
      ),
    );
  }
}
