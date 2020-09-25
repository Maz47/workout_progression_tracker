import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screen_notifier.dart';
import './theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>(
            create: (context) => ThemeNotifier()),
        ChangeNotifierProvider<ScreenNotifier>(
            create: (context) => ScreenNotifier()),
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeNotifier>(context).currentTheme.data,
      home: Scaffold(
        body: Provider.of<ScreenNotifier>(context).currentScreen,
        bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: Provider.of<ScreenNotifier>(context).currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (index) => Provider.of<ScreenNotifier>(context, listen: false)
          .changeScreen(index),
      items: [
        BottomNavigationBarItem(
          title: Text("Home"),
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          title: Text("Exercises"),
          icon: Icon(Icons.view_list),
        ),
        BottomNavigationBarItem(
          title: Text("Profile"),
          icon: Icon(Icons.account_circle),
        ),
        BottomNavigationBarItem(
          title: Text("Settings"),
          icon: Icon(Icons.settings),
        ),
      ],
    );
  }
}
