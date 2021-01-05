import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigHelper {
  static Future<bool> blurButtons() async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;

    await remoteConfig.fetch(expiration: const Duration(hours: 12));
    await remoteConfig.activateFetched();
    final response = remoteConfig.getBool('blur_buttons');
    return response;
  }
}
