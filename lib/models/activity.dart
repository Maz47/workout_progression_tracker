import 'package:cloud_firestore/cloud_firestore.dart';

class Activity {

  String exerciseId;
  DateTime date;

  Activity({this.exerciseId, String utcIsoDate}) {
    date = DateTime.parse(utcIsoDate);
  }

  static Activity fromDocument(DocumentSnapshot document, String exerciseId) {
    return Activity(
      exerciseId: exerciseId,
      utcIsoDate: document.data()['utc_iso_time'],
    );
  }
}
