import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:otspocket/models/projects.dart';
import 'package:otspocket/models/usermodel.dart';
import '../screens/homepage.dart';
import 'login.dart';

class registerPage extends StatefulWidget {
  @override
  _registerPage createState() => _registerPage();
}

class _registerPage extends State<registerPage> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  String? errorMessage;
  final fullNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final ssnEditingController = new TextEditingController();
  final phoneEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();

  bool p_state = true;
  vis() {
    setState(() {
      p_state = !p_state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 0,
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Image.asset(
                    "asset/images/logo.jpeg",
                    fit: BoxFit.cover,
                    height: 250,
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                Text(
                  "Register Yourself",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "to OT-Pocket",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 34),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: fullNameEditingController,
                        decoration: InputDecoration(
                            hintText: "User", labelText: "Full Name"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Full Name cannot not be empty";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          fullNameEditingController.text = value!;
                        },
                      ),
                      TextFormField(
                        controller: emailEditingController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: "example@ot-software.com",
                            labelText: "Email"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email cannot not be empty";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          emailEditingController.text = value!;
                        },
                      ),
                      TextFormField(
                        controller: phoneEditingController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintText: "1234567890", labelText: "Phone Number"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Phone Number cannot not be empty";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          phoneEditingController.text = value!;
                        },
                      ),
                      TextFormField(
                        controller: ssnEditingController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: "123456789", labelText: "SSN Number"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "SSN Number cannot not be empty";
                          }
                          if (value.length < 9 || value.length > 9) {
                            return "SSN Number should contain 9 digit";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          ssnEditingController.text = value!;
                        },
                      ),
                      TextFormField(
                        obscureText: p_state,
                        controller: passwordEditingController,
                        decoration: InputDecoration(
                            hintText: "Password",
                            labelText: "Password",
                            suffixIcon: InkWell(
                                onTap: vis, child: Icon(Icons.visibility))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password cannot not be empty";
                          } else if (value.length < 6) {
                            return "Password length should be atlist 6";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          passwordEditingController.text = value!;
                        },
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => signUp(emailEditingController.text,
                      passwordEditingController.text),
                  child: Text("Create",
                      style: TextStyle(
                        fontSize: 16,
                      )),
                  style: TextButton.styleFrom(
                      backgroundColor: Color(0xff45ac72),
                      minimumSize: Size(140, 40)),
                ),
                SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false,
                    );
                  },
                  child: Container(
                    child: Text(
                      "<< Back",
                      style: TextStyle(color: Color(0xff6C63FF), fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  String getRandomString(int length) {
    const characters =
        '+-*=?AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(length,
        (_) => characters.codeUnitAt(random.nextInt(characters.length))));
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();
    // Projects demoproj = Projects();

    String formattedDate = "2022-06-19";

    // demoproj.clientName = "Arkema, Clear Lake";
    // demoproj.po = "Arkema-987689";
    // demoproj.address = "Houston, Texas";
    // demoproj.jobDescriptions = "Phase ray/ UT and Eddy current Inspection";
    // demoproj.equipments = [
    //   "eq001",
    //   "eq002",
    //   "eq003",
    //   "eq004",
    //   "eq005",
    //   "eq006",
    //   "eq007"
    // ];
    // demoproj.equipQ = [3, 1, 4, 6, 2, 5, 1];
    // demoproj.consumables = ["con001", "con002", "con003"];
    // demoproj.consQ = [5, 50, 50];
    // demoproj.assignedEmployee = ["Texans", "Astros", "Rockets"];

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.fullname = fullNameEditingController.text;
    userModel.mobileNo = phoneEditingController.text;
    userModel.additional = "na";
    userModel.notificationid = "need to update";
    userModel.ssn = ssnEditingController.text;
    userModel.assignedprojects = "NA";
    userModel.uniqueid = fullNameEditingController.text.substring(0, 4) +
        ssnEditingController.text.substring(5, 9);
    //Fluttertoast.showToast(msg: formattedDate + userModel.fullname.toString());

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    // await firebaseFirestore
    //     .collection("userProjects")
    //     .doc("Arkema-987689")
    //     .set(demoproj.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :)");

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Homepage()),
      (route) => false,
    );
  }
}
