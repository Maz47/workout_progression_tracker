import 'package:flutter/material.dart';

import '../models/exercise.dart';
import 'exercise_activity_screen.dart';
import 'exercise_detail_screen.dart';

class ExerciseScreen extends StatefulWidget {
  final Exercise exercise;

  const ExerciseScreen({Key key, this.exercise}) : super(key: key);

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState(exercise);
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  
  final Exercise _exercise;
  int _currentIndex = 0;

  _ExerciseScreenState(this._exercise);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            title: Text("Details"),
            icon: Icon(Icons.assignment),
          ),
          BottomNavigationBarItem(
            title: Text("Activity"),
            icon: Icon(Icons.list),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    Widget result;
    switch (_currentIndex) {
      case 0:
        result = ExerciseDetailScreen(
          exercise: _exercise,
        );
        break;
      case 1:
        result = ExerciseActivityScreen(
          exercise: _exercise,
        );
        break;
      default:
        result = ExerciseDetailScreen(
          exercise: _exercise,
        );
        break;
    }
    return result;
  }
}
