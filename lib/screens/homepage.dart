// ignore_for_file: unnecessary_const

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otspocket/models/usermodel.dart';
import 'package:otspocket/screens/construction.dart';
import 'package:otspocket/screens/noKYC.dart';
import 'package:otspocket/screens/projectspage.dart';
import 'package:otspocket/screens/timesheet.dart';
import '../models/projects.dart';
import 'drawer.dart';

List<Projects> userprojects = [];
bool loading = false;

class Homepage extends StatefulWidget {
  @override
  _Homepage createState() => _Homepage();
}

class _Homepage extends State<Homepage> {
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
      setState(() {
        loading = true;
      });
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Tab> tabs = [
      const Tab(
          child: Text("Projects",
              style: const TextStyle(color: Color(0xff45ac72)))),
      const Tab(
          child: Text("Time Cards",
              style: const TextStyle(color: const Color(0xff45ac72)))),
    ];
    return loading == false
        ? Center(
            child: CircularProgressIndicator(
              color: Color(0xff487f4e),
              backgroundColor: Colors.white60,
            ),
          )
        : DefaultTabController(
            length: tabs.length,
            child: Scaffold(
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
                      tooltip: MaterialLocalizations.of(context)
                          .openAppDrawerTooltip,
                    );
                  },
                ),
                elevation: 4,
                centerTitle: true,
                backgroundColor: Colors.white,
                title: Text("OTS Pocket",
                    style: const TextStyle(
                        color: Color(0xff487f4e), fontSize: 24)),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(30),
                  child: TabBar(
                    indicatorColor: const Color(0xff54ccc4),
                    tabs: tabs,
                    //isScrollable: true,
                  ),
                ),
              ),
              body: TabBarView(children: [
                Projectspage(
                  activeuser: loggedInUser,
                ),
                Timesheet(activeuser: loggedInUser),
              ]),
              drawer: MyDrower(),
            ));
  }
}
