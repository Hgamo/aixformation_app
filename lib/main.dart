import 'package:aixformation_app/helper/remote_config_helper.dart';
import 'package:aixformation_app/main_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final initApp = FirebasePerformance.instance.newTrace('init_app');
  initApp.start();
  await Firebase.initializeApp();
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  final config = await RemoteConfigHelper.instance;
  runApp(
    Provider<RemoteConfigHelper>(
      create: (context) => config,
      child: AixformationApp(),
    ),
  );
  initApp.stop();
}

//flutter build apk --obfuscate --split-debug-info=build/app/outputs/symbols
//
//flutter build appbundle --obfuscate --split-debug-info=build/app/outputs/symbols
