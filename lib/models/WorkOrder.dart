class WorkOrder {
  String? po;
  String? wo;
  List<dynamic>? assignedEmployee;
  List<dynamic>? equipments;
  List<dynamic>? consumables;
  List<dynamic>? consQ;
  List<dynamic>? equipQ;
  WorkOrder(
      {this.po,
      this.wo,
      this.assignedEmployee,
      this.equipments,
      this.consumables,
      this.consQ,
      this.equipQ});
  factory WorkOrder.fromMap(map) {
    return WorkOrder(
      po: map['po'],
      wo: map['wo'],
      assignedEmployee: map['assignedEmployee'],
      equipments: map['equipments'],
      consumables: map['consumables'],
      consQ: map['consQ'],
      equipQ: map['equipQ'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'po': po,
      'wo': wo,
      'assignedEmployee': assignedEmployee,
      'equipments': equipments,
      'consumables': consumables,
      'consQ': consQ,
      'equipQ': equipQ,
    };
  }
}
