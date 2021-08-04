import 'package:dictionary_fschmatz/util/changelog.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppInfoPage extends StatelessWidget {
  _launchGithub() {
    const url = '';
    launch(url);
  }

  @override
  Widget build(BuildContext context) {
    Color? accentText = Theme.of(context).accentTextTheme.headline1!.color;

    return Scaffold(
        appBar: AppBar(
          title: Text("App Info"),
          elevation: 0,
        ),
        body: ListView(children: <Widget>[
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 55,
            backgroundColor: Colors.lightGreen,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/avatar.jpg'),
            ),
          ),
          const SizedBox(height: 15),
          Center(
            child: Text(Changelog.appName + " " + Changelog.appVersion,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: accentText)),
          ),
          const SizedBox(height: 15),
          const Divider(),
          ListTile(
            leading: SizedBox(
              height: 0.1,
            ),
            title: Text("Dev".toUpperCase(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: accentText)),
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text(
              "HAMMERED AND REDONE: 0 Times !!!",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          ListTile(
            leading: SizedBox(
              height: 0.1,
            ),
            title: Text(
              "Application created using Flutter and the Dart language, used for testing and learning.",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          const Divider(),
          ListTile(
            leading: SizedBox(
              height: 0.1,
            ),
            title: Text("Source Code".toUpperCase(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: accentText)),
          ),
          ListTile(
            //onTap: () {_launchGithub();},
            leading: Icon(Icons.open_in_new_outlined),
            title: Text("View on GitHub",
                style: TextStyle(
                    decoration: TextDecoration.underline, color: Colors.blue)),
          ),
          const Divider(),
          ListTile(
            leading: SizedBox(
              height: 0.1,
            ),
            title: Text("Quote".toUpperCase(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: accentText)),
          ),
          ListTile(
            leading: Icon(Icons.messenger_outline),
            title: Text(
              'It may be that when we no longer know what to do, '
              'we have come to our real work\n'
              'and when we no longer know which way to go, '
              'we have begun our real journey.\n'
              'The mind that is not baffled is not employed.\n'
              'The impeded stream is the one that sings.\n\n'
              'Wendell Berry',
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 50,)
        ]));
  }
}