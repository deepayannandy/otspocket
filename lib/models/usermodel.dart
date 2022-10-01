import 'package:otspocket/models/projects.dart';

class UserModel {
  String? uid;
  String? email;
  String? fullname;
  String? mobileNo;
  String? additional;
  String? notificationid;
  String? ssn;
  String? assignedprojects;
  String? uniqueid;

  UserModel({
    this.uid,
    this.email,
    this.fullname,
    this.mobileNo,
    this.notificationid,
    this.additional,
    this.ssn,
    this.assignedprojects,
    this.uniqueid,
  });

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        fullname: map['fullname'],
        mobileNo: map['mobileNo'],
        notificationid: map['notificationid'],
        additional: map['additional'],
        ssn: map['ssn'],
        assignedprojects: map['assignedprojects'],
        uniqueid: map["uniqueid"],
        );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullname': fullname,
      'mobileNo': mobileNo,
      'notificationid': notificationid,
      'additional': additional,
      'ssn': ssn,
      'assignedprojects': assignedprojects,
      "uniqueid": uniqueid
    };
  }
}
