import 'package:flutter/material.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Image.asset(
                  "asset/images/contact.png",
                  fit: BoxFit.cover,
                ),
                Text(
                  "Need Help, Contact us",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff6C63FF),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text:
                              'We are at OT-Software,always there to help you. We are extrimly sorry for the inconvinience. Call our support team or drop an email on the given phone number or email id. NOTE: Call facility is only availabe Monday to Friday 10 A.M to 6 P.M.',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontSize: 12,
                          ))),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Call Now: +1 (281) 309-6484",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.white,
                        )),
                  ),
                  onPressed: () async {
                    launch('tel://+12813096484');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurpleAccent,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Mail Us: support@ot-software.com",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.white,
                        )),
                  ),
                  onPressed: () async {
                    final url = Mailto(
                      to: [
                        'support@ot-software.com',
                      ],
                      subject: 'Customer Support',
                      body: 'Hey I need some help!',
                    ).toString();
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      /* showCupertinoDialog(
                    context: context,
                    builder: MailClientOpenErrorDialog(url: url).build,
                  ); */
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff54ccc4),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
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
                      style: TextStyle(color: Color(0xff6C63FF), fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
