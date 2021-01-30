import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigHelper {
  final RemoteConfig remoteConfig;
  RemoteConfigHelper({this.remoteConfig});

  static Future<RemoteConfigHelper> get instance async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;

    await remoteConfig.fetch();
    await remoteConfig.activateFetched();
    return RemoteConfigHelper(remoteConfig: remoteConfig);
  }

  bool blurButtons() {
    final response = remoteConfig.getBool('blur_buttons');
    return response ?? true;
  }

  bool showCovid() {
    final response = remoteConfig.getBool('show_covid');
    return response ?? false;
  }

  bool pinnedAppBar() {
    final response = remoteConfig.getBool('pinned_appbar');
    return response ?? true;
  }
}
