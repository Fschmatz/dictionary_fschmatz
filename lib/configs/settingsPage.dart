import 'package:dictionary_fschmatz/util/theme.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dictionary_fschmatz/util/changelog.dart';
import '../util/dialog_select_theme.dart';
import '../util/utils_functions.dart';
import 'appInfoPage.dart';
import 'changelogPage.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();

  const SettingsPage({Key? key}) : super(key: key);
}

class _SettingsPageState extends State<SettingsPage> {

  String getThemeStringFormatted(){
    String theme =  EasyDynamicTheme.of(context).themeMode.toString().replaceAll('ThemeMode.', '');
    if(theme == 'system'){theme = 'system default';}
    return capitalizeFirstLetterString(theme);
  }

  @override
  Widget build(BuildContext context) {

    Color? accent = Theme.of(context).colorScheme.primary;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
          elevation: 0,
        ),
        body: ListView(
          children: <Widget>[
            Card(
              elevation: 1,
              margin: const EdgeInsets.fromLTRB(16, 20, 16, 25),
              color: accent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: ListTile(
                title: Text(
                  Changelog.appName + " " + Changelog.appVersion,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 17.5),
                ),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const SizedBox(height: 0.1,),
              title:    Text(
                  "General".toUpperCase(),
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: accent)
              ),
            ),
            ListTile(
              onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const DialogSelectTheme();
                  }),
              leading: const Icon(Icons.brightness_6_outlined),
              title: const Text(
                "App Theme",
                style: TextStyle(fontSize: 16),
              ),
              subtitle: Text(
                getThemeStringFormatted(),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const SizedBox(height: 0.1,),
              title:    Text(
                  "About".toUpperCase(),
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: accent)
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.info_outline,
              ),
              title: const Text(
                "App Info",
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const AppInfoPage(),
                      fullscreenDialog: true,
                    ));
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            ListTile(
              leading: const Icon(
                Icons.article_outlined,
              ),
              title: const Text(
                "Changelog",
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const ChangelogPage(),
                      fullscreenDialog: true,
                    ));
              },
            ),
          ],
        ));
  }
}
