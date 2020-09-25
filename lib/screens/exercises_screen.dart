import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../models/exercise.dart';
import '../theme_notifier.dart';
import 'exercise_detail_screen.dart';
import 'exercise_screen.dart';

class ExercisesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercises"),
        centerTitle: true,
      ),
      body: _buildExercisesList(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            Provider.of<ThemeNotifier>(context).currentTheme.data.primaryColor,
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ExerciseDetailScreen(),
            ),
          ),
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  _buildExercisesList(BuildContext context) {
    CollectionReference exercises =
        FirebaseFirestore.instance.collection('exercises');

    return StreamBuilder<QuerySnapshot>(
      stream: exercises.snapshots(),
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
    );
  }

  ListView _buildList(
      AsyncSnapshot<QuerySnapshot> snapshot, BuildContext context) {
    return ListView(
      children: snapshot.data.docs.map((DocumentSnapshot document) {
        Exercise ex = Exercise.fromDocument(document);
        return new ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExerciseScreen(
                  exercise: ex,
                ),
              ),
            );
          },
          title: new Text(ex.name + " - " + ex.bodyPart),
          subtitle: new Text(ex.notes),
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
