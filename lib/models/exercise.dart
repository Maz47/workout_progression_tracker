import 'package:cloud_firestore/cloud_firestore.dart';

class Exercise {

  String docId;
  String name;
  String bodyPart;
  String notes;

  Exercise({this.docId = "", this.name = "", this.bodyPart = "", this.notes = ""});

  toMap() {
    return {
      'name': name,
      'body_part': bodyPart,
      'notes': notes,
    };
  }

  static Exercise fromMap(Map data) {
    return new Exercise(
        docId: data['id'].toString(),
        name: data['name'].toString(),
        bodyPart: data['body_part'].toString(),
        notes: data['notes'].toString());
  }

  static Exercise fromDocument(DocumentSnapshot document) {
    Exercise ex = fromMap(document.data());
    ex.docId = document.id;
    return ex;
  }

  @override
  String toString() {
    return "Exercise[docId: $docId, name: $name, bodyPart: $bodyPart, notes: $notes]";
  }
}
