import 'dart:developer';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otspocket/models/projects.dart';
import 'package:otspocket/models/timecard.dart';
import 'package:otspocket/models/usermodel.dart';
import 'package:otspocket/screens/homepage.dart';
import 'package:otspocket/screens/projectspage.dart';
import 'package:url_launcher/url_launcher.dart';

List<Projects> userprojects = [];
String shift = "Day Shift";
List shift_type = ["Day Shift", "Night Shift"];
bool loading = false;
DateTime now = DateTime.now();
String convertedDateTime =
    "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
String? today;

class SubmitTimeCard extends StatefulWidget {
  final UserModel activeuser;
  final Projects selectedproj;
  final String po_wo;
  const SubmitTimeCard(
      {required this.activeuser,
      required this.selectedproj,
      required this.po_wo})
      : super();

  @override
  State<SubmitTimeCard> createState() => _SubmitTimeCard();
}

class _SubmitTimeCard extends State<SubmitTimeCard> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController wh = new TextEditingController();
  final TextEditingController eh = new TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Fluttertoast.showToast(msg: widget.activeuser.fullname.toString());
    // Fluttertoast.showToast(msg: widget.selectedproj.projectname.toString());

    return Scaffold(
        appBar: AppBar(
          elevation: 4,
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Color(0xff487f4e)),
          title: Text("Time Card",
              textScaleFactor: 1.2, style: TextStyle(color: Color(0xff487f4e))),
        ),
        body: timecardbody(context));
  }

  timecardbody(BuildContext context) {
    return Material(
        color: Colors.white,
        child: Container(
            child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 5, 25, 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Employee name: " +
                            widget.activeuser.fullname.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Project name: " +
                            widget.selectedproj.clientName.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Project No: " + widget.selectedproj.po.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            today == null
                                ? "Date: " + convertedDateTime
                                : "Selected Sate: " + today!,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          RaisedButton(
                            child: Text("Change"),
                            onPressed: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2022),
                                      lastDate: DateTime(2023))
                                  .then((value) {
                                setState(() {
                                  DateTime? now = value;
                                  today =
                                      "${now!.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
                                  convertedDateTime = today!;
                                });
                              });
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text("Work Shift: ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          Spacer(),
                          DropdownButton(
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            hint: Text("Choose your Work Shift"),
                            value: shift,
                            items: shift_type.map((valueItem) {
                              return DropdownMenuItem(
                                  value: valueItem, child: Text(valueItem));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                shift = value.toString();
                              });
                              //Fluttertoast.showToast(msg: value.toString());
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          TextFormField(
                            controller: wh,
                            keyboardType: TextInputType.number,
                            cursorColor: Color(0xff6C63FF),
                            decoration: InputDecoration(
                                hintText: "8",
                                labelText: "Standard Working Hours"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Usual Working Hours cannot not be empty";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              wh.text = value!;
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          TextFormField(
                            controller: eh,
                            keyboardType: TextInputType.number,
                            cursorColor: Color(0xff6C63FF),
                            decoration: InputDecoration(
                                hintText: "8", labelText: "Over Working Hours"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Extra Working Hours cannot not be empty";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              eh.text = value!;
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            //Fluttertoast.showToast(msg: data);
                            uploadTimeData();
                          }
                        },
                        child: Text("Submit",
                            style: TextStyle(
                              fontSize: 16,
                            )),
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xff45ac72),
                          //minimumSize:size(140, 40)
                        ),
                      ),
                    ],
                  ),
                ))));
  }

  uploadTimeData() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    TimeCard card = TimeCard();
    card.date = today == null ? convertedDateTime : today!;
    card.st = double.parse(wh.text);
    card.ot = double.parse(eh.text);
    card.shift = shift == "Day Shift" ? true : false;
    card.wo = widget.po_wo;
    await firebaseFirestore
        .collection(widget.activeuser.uid! + "-timecards")
        .doc(convertedDateTime)
        .set(card.toMap());
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Homepage()),
      (route) => false,
    );
  }
}
