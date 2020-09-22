import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_progression_tracker/constants/body_parts.dart';

import '../models/exercise.dart';
import '../theme_notifier.dart';

class ExerciseDetailScreen extends StatefulWidget {
  final Exercise exercise;

  const ExerciseDetailScreen({Key key, this.exercise}) : super(key: key);

  @override
  _ExerciseDetailScreenState createState() =>
      _ExerciseDetailScreenState(exercise);
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _notesFocus = FocusNode();
  bool _isDialogOpen = false;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _notesController = new TextEditingController();
  String _bodyPart = "Body Part";
  bool _nameError = false;

  final Exercise _exercise;

  _ExerciseDetailScreenState(this._exercise);

  @override
  void initState() {
    super.initState();
    if (null != _exercise) {
      print(_exercise);
      _nameController.text = _exercise.name;
      _notesController.text = _exercise.notes;
      _bodyPart = _exercise.bodyPart;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text((null == _exercise) ? "New exercise" : "Update exercise"),
      ),
      body: Stack(
        children: [
          _buildInputScroll(context),
          if (_isDialogOpen) _buildBodyPartPickerDialog(context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String name = _nameController.text;
          if (name.isEmpty) {
            setState(() {
              _nameError = true;
            });
          } else {
            setState(() {
              _nameError = false;
            });
            String notes = _notesController.text;
            Exercise exercise = new Exercise(name: name, bodyPart: _bodyPart, notes: notes);
            if (null == _exercise) {
              FirebaseFirestore.instance
                .collection('exercises')
                .add(exercise.toMap())
                .then((value) => Navigator.pop(context))
                .catchError((error) => print("Failed to add exercise: $error"));
            } else {
              FirebaseFirestore.instance
                .collection('exercises')
                .doc(_exercise.docId)
                .update(exercise.toMap())
                .then((value) => Navigator.pop(context))
                .catchError((error) => print("Failed to update exercise: $error"));
            }
          }
        },
        backgroundColor:
            Provider.of<ThemeNotifier>(context).currentTheme.data.primaryColor,
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildInputScroll(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildNameTextField(context),
            SizedBox(
              height: 16.0,
            ),
            _buildNotesTextField(context),
            SizedBox(
              height: 16.0,
            ),
            _buildBodyPartPicker(context),
            SizedBox(
              height: 16.0,
            ),
            _buildBodyPartDisplay(context),
          ],
        ),
      ),
    );
  }

  Widget _buildNameTextField(BuildContext context) {
    return TextField(
      focusNode: _nameFocus,
      decoration: InputDecoration(
        labelText: "Name",
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusColor:
            Provider.of<ThemeNotifier>(context).currentTheme.data.accentColor,
        isDense: true,
        errorText: _nameError ? "Name has to be defined!" : null,
      ),
      controller: _nameController,
      textInputAction: TextInputAction.next,
      cursorColor:
          Provider.of<ThemeNotifier>(context).currentTheme.data.accentColor,
      onSubmitted: (term) {
        _nameFocus.unfocus();
        FocusScope.of(context).requestFocus(_notesFocus);
        setState(() {
          _nameError = _nameController.text.isEmpty;
        });
      },
    );
  }

  Widget _buildNotesTextField(BuildContext context) {
    return TextField(
      focusNode: _notesFocus,
      decoration: InputDecoration(
        labelText: "Notes",
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusColor:
            Provider.of<ThemeNotifier>(context).currentTheme.data.accentColor,
        isDense: true,
      ),
      controller: _notesController,
      minLines: 3,
      maxLines: 3,
      cursorColor:
          Provider.of<ThemeNotifier>(context).currentTheme.data.accentColor,
    );
  }

  Widget _buildBodyPartPicker(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _nameFocus.unfocus();
          _notesFocus.unfocus();
          _isDialogOpen = true;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Colors.white38,
          ),
          color: Colors.white10,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(
                _bodyPart,
                style: TextStyle(
                  color: Colors.white38,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBodyPartDisplay(BuildContext context) {
    return Container(
      height: 500,
      child: Image.asset(
        getImageAsset(),
        alignment: Alignment.topCenter,
      ),
    );
  }

  String getImageAsset() {
    String result = "assets/muscle_body.png";
    switch (_bodyPart) {
      case BODY_PART_CORE:
        result = "assets/muscle_body_abs.png";
        break;
      case BODY_PART_ARMS:
        result = "assets/muscle_body_arms.png";
        break;
      case BODY_PART_BACK:
        result = "assets/muscle_body_back.png";
        break;
      case BODY_PART_CHEST:
        result = "assets/muscle_body_chest.png";
        break;
      case BODY_PART_LEGS:
        result = "assets/muscle_body_legs.png";
        break;
      case BODY_PART_SHOULDERS:
        result = "assets/muscle_body_shoulders.png";
        break;
    }
    return result;
  }

  Widget _buildBodyPartPickerDialog(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 200),
        child: Card(
          elevation: 8.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: ALL_BODY_PARTS.length,
              itemBuilder: (BuildContext context, int index) {
                return RadioListTile(
                  selected: (_bodyPart == ALL_BODY_PARTS[index]),
                  groupValue: _bodyPart,
                  value: ALL_BODY_PARTS[index],
                  onChanged: (value) {
                    setState(() {
                      _bodyPart = value;
                      _isDialogOpen = false;
                    });
                  },
                  title: Text(ALL_BODY_PARTS[index]),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
