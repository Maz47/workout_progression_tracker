import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../models/activity.dart';

import '../models/exercise.dart';
import '../theme_notifier.dart';

class ExerciseActivityScreen extends StatefulWidget {
  final Exercise exercise;

  const ExerciseActivityScreen({Key key, this.exercise}) : super(key: key);

  @override
  _ExerciseActivityScreenState createState() =>
      _ExerciseActivityScreenState(exercise);
}

class _ExerciseActivityScreenState extends State<ExerciseActivityScreen> {
  final Exercise _exercise;

  _ExerciseActivityScreenState(this._exercise);

  @override
  Widget build(BuildContext context) {
    CollectionReference activities = FirebaseFirestore.instance
        .collection('activities')
        .doc(_exercise.docId)
        .collection("activities");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Activity"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: activities.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Something went wrong',
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text(
                "Loading",
              ),
            );
          }
          if ((snapshot.data.docs.length > 0))
            return _buildList(snapshot, context);
          else
            return _buildNoData();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor:
            Provider.of<ThemeNotifier>(context).currentTheme.data.primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  ListView _buildList(
      AsyncSnapshot<QuerySnapshot> snapshot, BuildContext context) {
    return ListView(
      children: snapshot.data.docs.map((DocumentSnapshot document) {
        Activity activity = Activity.fromDocument(document, _exercise.docId);
        return new ListTile(
          onTap: () {},
          title: new Text(activity.date.toLocal().toString()),
        );
      }).toList(),
    );
  }

  Center _buildNoData() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/nod_data_cyan.svg",
            width: 200,
          ),
          SizedBox(
            height: 32.0,
          ),
          Text("No exercises available yet!"),
        ],
      ),
    );
  }
}
