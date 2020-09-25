import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/custom_theme.dart';
import '../theme_notifier.dart';
import 'theme_chooser.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CustomTheme theme = Provider.of<ThemeNotifier>(context).currentTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "General Settings",
              style: TextStyle(
                color: Colors.grey[400],
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              dense: true,
              title: Text("Language"),
              subtitle: Text("en"),
              trailing: Icon(Icons.chevron_right),
              onTap: () => {},
            ),
            ListTile(
              dense: true,
              title: Text("Unit"),
              subtitle: Text("metric"),
              trailing: Icon(Icons.chevron_right),
              onTap: () => {},
            ),
            ListTile(
              dense: true,
              title: Text("Theme"),
              subtitle: Text(theme.name),
              trailing: Icon(Icons.chevron_right),
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ThemeChooser()))
              },
            ),
          ],
        ),
      ),
    );
  }
}
