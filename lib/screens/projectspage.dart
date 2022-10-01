import 'dart:developer';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otspocket/models/WorkOrder.dart';
import 'package:otspocket/models/projects.dart';
import 'package:otspocket/models/usermodel.dart';
import 'package:otspocket/screens/submitTimecard.dart';
import 'package:url_launcher/url_launcher.dart';

// List<Projects> userprojects = [];
bool loading = false;
WorkOrder? WO;
Projects? PO;
String? powo;

class Projectspage extends StatefulWidget {
  final UserModel activeuser;
  const Projectspage({required this.activeuser}) : super();

  @override
  State<Projectspage> createState() => _ProjectspageState();
}

class _ProjectspageState extends State<Projectspage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String? assignp = widget.activeuser.assignedprojects;
    powo = assignp;
    String? wo = assignp?.split('~')[1];
    //Fluttertoast.showToast(msg: wo.toString());
    FirebaseFirestore.instance
        .collection("Workorders")
        .where("wo", isEqualTo: wo)
        .get()
        .then((value) {
      if (value.size > 0) {
        //Fluttertoast.showToast(msg: value.size.toString());
        setState(() {
          WO = WorkOrder.fromMap(value.docs[0]);
          //Fluttertoast.showToast(msg: WO!.po.toString());
          getpoData(WO!.po.toString());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading == false
        ? Center(
            child: CircularProgressIndicator(
              color: Color(0xff487f4e),
              backgroundColor: Colors.white60,
            ),
          )
        : WO != null
            ? Padding(
                padding: const EdgeInsets.fromLTRB(2, 5, 2, 5),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Column(
                      children: [
                        tiles(WO!),
                      ],
                    ),
                  ),
                ),
              )
            : Material(
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
                        "You are not assigned to any project!",
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
                ));
  }

  getpoData(String po) {
    loading = true;
    FirebaseFirestore.instance
        .collection("userProjects")
        .where("po", isEqualTo: po)
        .get()
        .then((value) {
      if (value.size > 0) {
        //Fluttertoast.showToast(msg: value.size.toString());
        setState(() {
          PO = Projects.fromMap(value.docs[0]);
          //Fluttertoast.showToast(msg: PO!.clientName.toString());
        });
      }
    });
  }

  tiles(WorkOrder Wo) {
    //Fluttertoast.showToast(msg: widget.activeuser.email.toString());
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
                    color: Color(0xff84a47c),
                  )),
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
              right: 0,
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SubmitTimeCard(
                                activeuser: widget.activeuser,
                                selectedproj: PO!,
                                po_wo: powo.toString(),
                              )));
                },
                color: Color(0xff045004),
                textColor: Colors.white,
                child: Row(
                  children: [
                    Text("Submit Timecard"),
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
                      Text(PO!.clientName.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Address: " + PO!.address.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                          "PO No.: " +
                              Wo.po.toString() +
                              " WO N0.: " +
                              WO!.wo.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Text(PO!.jobDescriptions.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
