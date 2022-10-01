import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

List<List<String>> services = [
  [
    "SaltTherapy",
    "asset/images/salt.jpg",
    "During a session, when microscopic salt particles are inhaled into the airways and lungs, it stimulates the body’s action of cilia movement. ",
    "https://saltworld.in/how-salt-therapy-work"
  ],
  [
    "Floatation Tank",
    "asset/images/float2.jpg",
    "A sensory deprivation tank, also called a float tank or isolation tank offers a distraction free environment that helps you experience a completely relaxed float therapy.",
    "https://saltworld.in/sensory-deprivation-tank"
  ],
  [
    "Product - EPSOM SALT",
    "asset/images/SaltLamp_Salt_Therapy.jpg",
    "The therapeutic use of Epsom Salt dates back to the 18th Century where it was first discovered in the bitter saline springs in Epsom in Surrey, England. Since then it has been ardently used in the fields of health, beauty and agriculture.",
    "https://saltworld.in/epsom-salt"
  ]
];

class home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Fluttertoast.showToast(msg: services.length.toString());
    // Fluttertoast.showToast(msg: services[0][1]);
    return SingleChildScrollView(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("asset/images/add.png"),
        ),
        SizedBox(
          height: 10,
        ),
        tiles(services[0]),
        tiles(services[1]),
        tiles(services[2]),
        SizedBox(
          height: 20,
        ),
      ]),
    );
  }

  tiles(service) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 180,
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  service[1],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 130,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                      Colors.black.withOpacity(1),
                      Colors.transparent
                    ])),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: MaterialButton(
                onPressed: () {
                  launch(service[3]);
                },
                color: Color(0xff54ccc4),
                textColor: Colors.white,
                child: Row(
                  children: [
                    Text("Know More "),
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
                      Text(service[0],
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Text(service[2],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ))
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
