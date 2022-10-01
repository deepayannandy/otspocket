import 'package:flutter/material.dart';

class underConst extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              SizedBox(
                height: 70,
              ),
              Image.asset(
                "asset/images/construction.png",
                fit: BoxFit.cover,
              ),
              Text(
                "This Page is Under Construction",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  child: Text(
                    "Go Back",
                    style: TextStyle(color: Color(0xff13a693)),
                  ),
                ),
              )
            ]),
          ),
        ));
  }
}
