import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otspocket/auth/registration.dart';
import 'package:otspocket/screens/admin.dart';

import '../screens/homepage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final _auth = FirebaseAuth.instance;
  String? errorMessage = "";
  bool p_state = true;
  vis() {
    setState(() {
      p_state = !p_state;
    });
  }

  @override
  void initState() {
    super.initState();
    _checklogin();
  }

  Future<void> _checklogin() async {
    User? user = _auth.currentUser;
    if (user == null) {
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => Homepage())); //Homepage()
      Fluttertoast.showToast(msg: "Welcome Back!");
    }
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
                  "Welcome",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "OT-Pocket Login Page",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 34),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: "example@ot-software.com",
                            labelText: "Email Id"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Username cannot not be empty";
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Please Enter a valid email");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          emailController.text = value!;
                        },
                      ),
                      TextFormField(
                        obscureText: p_state,
                        controller: passwordController,
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
                          passwordController.text = value!;
                        },
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    sigin(emailController.text, passwordController.text);
                  },
                  child: Text("Login",
                      style: TextStyle(
                        fontSize: 16,
                      )),
                  style: TextButton.styleFrom(
                      backgroundColor: Color(0xff45ac72),
                      minimumSize: Size(140, 40)),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  errorMessage!,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => registerPage()));
                  },
                  child: Container(
                    child: Text(
                      "Register Now >>",
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

  void sigin(String email, String password) async {
    // Fluttertoast.showToast(msg: email + password);
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Homepage()), //HomePage()
                    (route) => false,
                  )
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
        setState(() {
          errorMessage = errorMessage;
        });
        //showErrorTopSnackBar(errorMessage!);
        print(error.code);
      }
    }
  }
}
