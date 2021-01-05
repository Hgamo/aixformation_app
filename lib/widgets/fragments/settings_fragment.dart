import 'package:aixformation_app/helper/auth_helper.dart';
import 'package:aixformation_app/shared/website_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class SettingsFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Auth.getAuthstate();
    return ListView(
      children: [
        SizedBox(
          height: 70,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 130, right: 130),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(1000000000000),
            clipBehavior: Clip.antiAlias,
            child: user.isAnonymous
                ? Icon(
                    Icons.person,
                    size: 50,
                  )
                : Image.network(
                    user.photoURL,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          user.displayName ?? user.uid,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Text(
          user.email ?? '',
          textAlign: TextAlign.center,
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.info),
          title: Text('App Info'),
          onTap: () => showLicensePage(context: context),
        ),
        Divider(),
        ListTile(
          title: Text('Impressum'),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                settings: RouteSettings(name: 'Impressum Screen'),
                builder: (context) => WebsiteScreen(
                  title: 'Impressum',
                  url: 'https://aixmedia.org/imprint/',
                ),
              ),
            );
          },
          leading: Icon(Icons.insert_drive_file),
        ),
        ListTile(
          title: Text('Datenschutzerklärung'),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                settings: RouteSettings(name: 'Datenschutzerklärung Screen'),
                builder: (context) => WebsiteScreen(
                  title: 'Datenschutzerklärung',
                  url: 'https://aixformation.de/datenschutzerklaerung/',
                ),
              ),
            );
          },
          leading: Icon(Icons.insert_drive_file),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Logout'),
          onTap: () => Auth.signOut(),
        ),
        ListTile(
          leading: Icon(Icons.delete_forever),
          title: Text('Account Löschen'),
          onTap: () async {
            final result = await Connectivity().checkConnectivity();
            showDialog(
              context: context,
              builder: (context) => result == ConnectivityResult.none
                  ? AlertDialog(
                      title: Text('Keine Internetverbindung'),
                      content: Text(
                          'Um deinen Account zu löschen musst du eine Verbindung mit dem Internet herstellen.'),
                      actions: [
                        TextButton(
                          child: Text(
                            'Ok',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    )
                  : AlertDialog(
                      title: Text('Achtung'),
                      content: Text(
                          'Alle deine Daten werden gelöscht. Bist du dir sicher?'),
                      actions: [
                        TextButton(
                          child: Text('Löschen',
                              style: TextStyle(color: Colors.red)),
                          onPressed: () {
                            Auth.deleteForever();
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text(
                            'Abbrechen',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
            );
          },
        ),
      ],
    );
  }
}