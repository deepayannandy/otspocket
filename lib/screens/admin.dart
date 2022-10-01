import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:otspocket/screens/drawer.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../main.dart';
import 'home.dart';

List<String> tasks = [
  "Project Tracking",
  "Employee database",
  "Equipment database",
  "Consumable inventory",
  "Payroll",
  "Sales report"
];

class Admin extends StatefulWidget {
  @override
  _Admin createState() => _Admin();
}

class _Admin extends State<Admin> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Color(0xff487f4e),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        elevation: 8,
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text("OTS Admin",
            textScaleFactor: 1, style: TextStyle(color: Color(0xff487f4e))),
      ),
      body: actionsbody(),
      drawer: MyDrower(),
    );
  }

  actionsbody() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 5, 2, 5),
      child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, int index) {
            final task = tasks[index];
            return taskcard(task);
          }),
    );
  }

  taskcard(String task) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(task,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 28,
                          color: Colors.black54,
                        )),
                  ),
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
