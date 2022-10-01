import 'dart:ffi';

class TimeCard {
  String? date;
  bool? shift;
  double? st;
  double? ot;

  String? wo;
  TimeCard({this.date, this.ot, this.shift, this.st, this.wo});
  factory TimeCard.fromMap(map) {
    return TimeCard(
      date: map['date'],
      shift: map['shift'],
      st: map['st'],
      ot: map['ot'],
      wo: map['wo'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'shift': shift,
      'st': st,
      'ot': ot,
      'wo': wo,
    };
  }
}
