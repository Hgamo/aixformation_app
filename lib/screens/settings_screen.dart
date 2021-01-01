import 'package:aixformation_app/helper/auth_helper.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
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
          title: Text('Info'),
          onTap: () => showLicensePage(context: context),
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
          onTap: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Achtung'),
              content:
                  Text('Alle deine Daten werden gelöscht. Bist du dir sicher?'),
              actions: [
                TextButton(
                  child: Text('Löschen', style: TextStyle(color: Colors.red)),
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
          ),
        ),
      ],
    );
  }
}
