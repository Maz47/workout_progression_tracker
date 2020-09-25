import 'package:flutter/material.dart';

import '../models/custom_theme.dart';

final CustomTheme kDefaultTheme = CustomTheme("Default", ThemeData.dark());
final CustomTheme kRedTheme = new CustomTheme(
  "red",
  ThemeData.dark().copyWith(
    primaryColor: Colors.red,
    accentColor: Colors.redAccent,
  ),
);
final CustomTheme kGreenTheme = new CustomTheme(
  "green",
  ThemeData.dark().copyWith(
    primaryColor: Colors.green,
    accentColor: Colors.greenAccent,
  ),
);
final CustomTheme kBlueTheme = new CustomTheme(
  "blue",
  ThemeData.dark().copyWith(
    primaryColor: Colors.blue,
    accentColor: Colors.blueAccent,
  ),
);
final CustomTheme kDeepPurpleTheme = new CustomTheme(
  "deep purple",
  ThemeData.dark().copyWith(
    primaryColor: Colors.deepPurple,
    accentColor: Colors.deepPurpleAccent,
  ),
);
final CustomTheme kLimeTheme = new CustomTheme(
  "lime",
  ThemeData.dark().copyWith(
    primaryColor: Colors.lime,
    accentColor: Colors.limeAccent,
  ),
);
final CustomTheme kAmberTheme = new CustomTheme(
  "amber",
  ThemeData.dark().copyWith(
    primaryColor: Colors.amber,
    accentColor: Colors.amberAccent,
  ),
);
final CustomTheme kCyanTheme = new CustomTheme(
  "cyan",
  ThemeData.dark().copyWith(
    primaryColor: Colors.cyan,
    accentColor: Colors.cyanAccent,
  ),
);
final CustomTheme kDeepOrangeTheme = new CustomTheme(
  "deep orange",
  ThemeData.dark().copyWith(
    primaryColor: Colors.deepOrange,
    accentColor: Colors.deepOrangeAccent,
  ),
);
final CustomTheme kIndigoTheme = new CustomTheme(
  "indigo",
  ThemeData.dark().copyWith(
    primaryColor: Colors.indigo,
    accentColor: Colors.indigoAccent,
  ),
);
final CustomTheme kLightBlueTheme = new CustomTheme(
  "light blue",
  ThemeData.dark().copyWith(
    primaryColor: Colors.lightBlue,
    accentColor: Colors.lightBlueAccent,
  ),
);
final CustomTheme kLightGreenTheme = new CustomTheme(
  "light green",
  ThemeData.dark().copyWith(
    primaryColor: Colors.lightGreen,
    accentColor: Colors.lightGreenAccent,
  ),
);
final CustomTheme kOrangeTheme = new CustomTheme(
  "orange",
  ThemeData.dark().copyWith(
    primaryColor: Colors.orange,
    accentColor: Colors.orangeAccent,
  ),
);
final CustomTheme kPinkTheme = new CustomTheme(
  "pink",
  ThemeData.dark().copyWith(
    primaryColor: Colors.pink,
    accentColor: Colors.pinkAccent,
  ),
);
final CustomTheme kPurpleTheme = new CustomTheme(
  "purple",
  ThemeData.dark().copyWith(
    primaryColor: Colors.purple,
    accentColor: Colors.purpleAccent,
  ),
);
final CustomTheme kTealTheme = new CustomTheme(
  "teal",
  ThemeData.dark().copyWith(
    primaryColor: Colors.teal,
    accentColor: Colors.tealAccent,
  ),
);
final CustomTheme kYellowTheme = new CustomTheme(
  "yellow",
  ThemeData.dark().copyWith(
    primaryColor: Colors.yellow,
    accentColor: Colors.yellowAccent,
  ),
);
final List<CustomTheme> kAvailabelThemes = [
  kDefaultTheme,
  kRedTheme,
  kGreenTheme,
  kBlueTheme,
  kDeepPurpleTheme,
  kLimeTheme,
  kAmberTheme,
  kCyanTheme,
  kDeepOrangeTheme,
  kIndigoTheme,
  kLightBlueTheme,
  kLightGreenTheme,
  kOrangeTheme,
  kPinkTheme,
  kPurpleTheme,
  kTealTheme,
  kYellowTheme,
];