import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme_notifier.dart';

class ExercisesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercises"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Provider.of<ThemeNotifier>(context).currentTheme.data.primaryColor,
        onPressed: () => {},
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
