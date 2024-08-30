class EmergencyContact {
  final int? id;
  final String name;
  final String number;

  EmergencyContact({this.id, required this.name, required this.number});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'number': number,
    };
  }

  factory EmergencyContact.fromMap(Map<String, dynamic> map) {
    return EmergencyContact(
      id: map['id'],
      name: map['name'],
      number: map['number'],
    );
  }
}
