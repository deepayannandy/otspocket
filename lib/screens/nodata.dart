import 'package:flutter/material.dart';

class noData extends StatelessWidget {
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
        ));
  }
}
