import 'dart:developer';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otspocket/models/timecard.dart';
import 'package:otspocket/screens/homepage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/usermodel.dart';
import 'nodata.dart';

List<TimeCard> Cards = [];
bool loading = true;

class Timesheet extends StatefulWidget {
  final UserModel activeuser;
  const Timesheet({required this.activeuser}) : super();

  @override
  State<Timesheet> createState() => _TimesheetState();
}

class _TimesheetState extends State<Timesheet> {
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection(widget.activeuser.uid.toString() + "-timecards")
        .get()
        .then((value) async {
      var docs = value.docs;
      Cards.clear();
      //Fluttertoast.showToast(msg: docs.length.toString());
      for (int i = 0; i < docs.length; i++) {
        TimeCard tc = TimeCard();
        tc.date = docs[i].get("date");
        tc.ot = docs[i].get("ot");
        tc.shift = docs[i].get("shift");
        tc.st = docs[i].get("st");
        tc.wo = docs[i].get("wo");
        Cards.add(tc);
      }
      setState(() {
        loading = false;
        Fluttertoast.showToast(msg: Cards.length.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //Fluttertoast.showToast(msg: services.length.toString());
    // Fluttertoast.showToast(msg: services[0][1]);
    return loading == true
        ? Center(
            child: CircularProgressIndicator(
              color: Color(0xff487f4e),
              backgroundColor: Colors.white60,
            ),
          )
        : Cards.isEmpty == true
            ? Material(
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(children: [
                      SizedBox(
                        height: 70,
                      ),
                      Image.asset(
                        "asset/images/nodata.png",
                        fit: BoxFit.cover,
                      ),
                      Text(
                        "No data found",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ]),
                  ),
                ))
            : Padding(
                padding: const EdgeInsets.fromLTRB(2, 5, 2, 5),
                child: ListView.builder(
                    itemCount: Cards.length,
                    itemBuilder: (context, int index) {
                      final attd = Cards[index];
                      return attendence(attd);
                    }),
              );
  }

  attendence(TimeCard cd) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("PO and WO",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        color: Colors.black54,
                      )),
                  Spacer(),
                  Text("Date",
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
                  Text(cd.wo.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color(0xff13a693),
                      )),
                  Spacer(),
                  Text(cd.date.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Color(0xff13a693),
                      )),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Spacer(),
                  Text("SWH",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black54,
                      )),
                  Spacer(),
                  Text("OTH",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black54,
                      )),
                  Spacer(),
                  Text("Shift",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black54,
                      )),
                  Spacer(),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Spacer(),
                  Text(cd.st.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black54,
                      )),
                  Spacer(),
                  Text(cd.ot.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black54,
                      )),
                  Spacer(),
                  Text(cd.shift == true ? "Day" : "Night",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black54,
                      )),
                  Spacer(),
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
      ),
    );
  }
}
