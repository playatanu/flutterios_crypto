import 'package:flutter/material.dart';
import 'package:flutterios_crypto/providers/theme_notifier.dart';
import 'package:flutterios_crypto/providers/themedata.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  var _darkTheme = true;
  bool isAndroidView = false;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        // ignore: avoid_unnecessary_containers
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Dark Mode'),
                  Switch(
                    value: _darkTheme,
                    onChanged: (val) {
                      setState(() {
                        _darkTheme = val;

                        print(_darkTheme);
                      });
                      onThemeChanged(val, themeNotifier);
                    },
                    activeTrackColor: Colors.yellow,
                    activeColor: Colors.orangeAccent,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Android View'),
                  Switch(
                    value: isAndroidView,
                    onChanged: (value) {
                      setState(() {
                        isAndroidView = value;
                        print(isAndroidView);
                      });
                    },
                    activeTrackColor: Colors.yellow,
                    activeColor: Colors.orangeAccent,
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    (value)
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', value);
  }
}
