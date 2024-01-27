import 'dart:ffi';

class Entry {
  static String table = "entries";

  int? id;
  Array positions;
  String? duration;
  double? speed;
  double? distance;


  Entry({this.id, required this.positions});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'positions': positions,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  static Entry fromMap(Map<String, dynamic> map) {
    return Entry(
        id: map['id'],
        positions: map['positions']);

  }
}