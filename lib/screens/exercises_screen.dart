import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/exercise.dart';
import '../theme_notifier.dart';
import 'exercise_detail_screen.dart';

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
    CollectionReference users =
        FirebaseFirestore.instance.collection('exercises');

    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            Exercise ex = Exercise.fromDocument(document);
            return new ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExerciseDetailScreen(
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
      },
    );
  }
}
