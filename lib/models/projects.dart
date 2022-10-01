import 'dart:ffi';

class Projects {
  String? po;
  String? address;
  String? clientName;
  String? jobDescriptions;
  List<dynamic>? workorders;
  int? woc;

  Projects({
    this.po,
    this.address,
    this.clientName,
    this.jobDescriptions,
    this.workorders,
    this.woc,
  });
  factory Projects.fromMap(map) {
    return Projects(
      po: map['po'],
      address: map['address'],
      clientName: map['clientName'],
      jobDescriptions: map['jobDescriptions'],
      workorders: map['workorders'],
      woc: map["woc"],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'po': po,
      'address': address,
      'clientName': clientName,
      'jobDescriptions': jobDescriptions,
      'workorders': workorders,
      'woc': woc,
    };
  }
}
