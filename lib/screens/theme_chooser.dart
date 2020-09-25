import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/themes.dart';
import '../models/custom_theme.dart';
import '../theme_notifier.dart';

class ThemeChooser extends StatelessWidget {
  const ThemeChooser({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Choose a theme!"),
      ),
      body: ListView.builder(
        itemCount: kAvailabelThemes.length,
        itemBuilder: (BuildContext context, int index) {
          CustomTheme theme = kAvailabelThemes[index];
          return InkWell(
            onTap: () => {
              Provider.of<ThemeNotifier>(context, listen: false).changeTheme(theme),
              Navigator.pop(context),
            },
            child: Container(
              height: 50,
              color: theme.data.primaryColor,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (Provider.of<ThemeNotifier>(context).currentTheme.name == theme.name) Icon(Icons.check_circle, size: 24,)
                  else Text(
                    theme.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
