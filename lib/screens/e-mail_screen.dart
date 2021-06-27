import 'package:aixformation_app/helper/auth_helper.dart';
import 'package:aixformation_app/helper/auth_state_helper.dart';
import 'package:aixformation_app/shared/auth_status_enum.dart';
import 'package:aixformation_app/shared/colors.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class EMailScreen extends StatefulWidget {
  @override
  _EMailScreenState createState() => _EMailScreenState();
}

class _EMailScreenState extends State<EMailScreen> {
  final _formKey = GlobalKey<FormState>();
  String eMail;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Einloggen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Auhuur Magazin !',
              style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 50,),
              textAlign: TextAlign.center,
            ),
            Theme(
              data: ThemeData(
                brightness:
                    MediaQuery.of(context).platformBrightness == Brightness.dark
                        ? Brightness.dark
                        : Brightness.light,
                primarySwatch: ahYellow,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) => eMail = value,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "E-Mail",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (!EmailValidator.validate(value)) {
                          return 'Die E-Mail Adresse ist nicht richtig';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onChanged: (value) => password = value,
                      decoration: InputDecoration(
                        labelText: 'Passwort',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value.length < 8) {
                          return 'Das Passwort muss mindestenz 8 Zeichen lang sein';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).accentColor),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      child: Text('Einloggen/Registrieren'),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          final result = await Auth.logInEandP(
                            eMail: eMail,
                            password: password,
                          );
                          if (result == AuthResultStatus.successful) {
                            print('Der Login war erfolgreich');
                            final analytics = FirebaseAnalytics();
                            analytics.setUserId(Auth.getAuthstate().uid);
                            analytics.setUserProperty(
                                name: 'login_methode', value: 'E-Mail');
                            analytics.logLogin();
                            Navigator.pop(context);
                            return;
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: Text(
                                  AuthExceptionHandler.generateExceptionMessage(
                                      result),
                                ),
                              ),
                            );
                          }
                        }
                      },
                    ),
                    MaterialButton(
                      child: Text('Passwort zurücksetzen'),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => ResetPasswordDialog(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResetPasswordDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String resetEmail = '';
    return StatefulBuilder(builder: (context, setState) {
      return Theme(
        data: ThemeData(
          brightness:
              MediaQuery.of(context).platformBrightness == Brightness.dark
                  ? Brightness.dark
                  : Brightness.light,
          primarySwatch: ahYellow,
        ),
        child: AlertDialog(
          title: Text('Passwort zurücksetzen'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                resetEmail = value;
              });
            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "E-Mail",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            MaterialButton(
              child: Text('zurücksetzen'),
              onPressed: EmailValidator.validate(resetEmail)
                  ? () async {
                      FirebaseAuth.instance
                          .sendPasswordResetEmail(email: resetEmail);
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('E-Mail wurde losgeschickt'),
                          content: Text(
                              'Eine E-Miail zum Zurücksetzen des Passworts wurde an deine E-Mail Adresse gesendet'),
                          actions: [
                            MaterialButton(
                              child: Text('Ok'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      );
                    }
                  : null,
            )
          ],
        ),
      );
    });
  }
}
