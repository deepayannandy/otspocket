import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../auth/login.dart';

class OnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "One app for all your business needs",
            image: Image.asset(
              "asset/images/work.png",
              fit: BoxFit.contain,

              //height: ,
            ),
            body: "Mange and track your employee data and tasks from one app.",
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: "Manage TimeSheets",
            image: Image.asset(
              "asset/images/attandence.png",
              fit: BoxFit.contain,

              //height: ,
            ),
            body:
                "Manage users timesheets and get real time update from the employees using this application.",
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: "Make accounting simple",
            image: Image.asset(
              "asset/images/hr.png",
              fit: BoxFit.contain,

              //height: ,
            ),
            body:
                "Manage all the HR related tasks from one app without westing time on huge excel files.",
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: "Save time",
            image: Image.asset(
              "asset/images/easy operation.png",
              fit: BoxFit.contain,

              //height: ,
            ),
            body:
                "Using our OTS Pocket software make all the boring paperworks from one click in your cell phone.",
            decoration: getPageDecoration(),
          ),
        ],
        done: Text("Login",
            style: TextStyle(color: Color(0xff13a693), fontSize: 18)),
        next: Icon(Icons.arrow_forward_ios),
        skip: Text("Skip",
            style: TextStyle(color: Color(0xff13a693), fontSize: 18)),
        onDone: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false,
          );
        },
        showNextButton: true,
        showSkipButton: true,
        dotsDecorator: getdotsdecor(),
      ),
    );
  }

  PageDecoration getPageDecoration() => PageDecoration(
        bodyTextStyle: TextStyle(fontSize: 16, color: Colors.black54),
        titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xff13a693)),
      );
  DotsDecorator getdotsdecor() => DotsDecorator(
        activeColor: Color(0xff13a693),
        size: Size(5, 5),
        activeSize: Size(22, 10),
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      );
}
