import 'package:flutter/material.dart';

import '../models/exercise.dart';

class ExerciseListItem extends StatelessWidget {
  final Exercise _exercise;

  const ExerciseListItem(this._exercise, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(_exercise.id.toString()),
          Text(_exercise.name),
        ],
      ),
    );
  }
}
