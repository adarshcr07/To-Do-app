import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class FirebaseRemoteConfigService {
  FirebaseRemoteConfigService._()
      : _remoteConfig = FirebaseRemoteConfig.instance;
  static FirebaseRemoteConfigService? _instance;
  factory FirebaseRemoteConfigService() =>
      _instance ??= FirebaseRemoteConfigService._();
  final FirebaseRemoteConfig _remoteConfig;

  String getString(String key) => _remoteConfig.getString(key);
  // bool getBool(String key) => _remoteConfig.getBool(key);
  //int getInt(String key) => _remoteConfig.getInt(key);
  //double getDouble(String key) => _remoteConfig.getDouble(key);

  Future<void> initialize() async {
    await _setConfigSettings();
    // await _setDefaults();
    await fetchAndActivate();
  }

  Future<void> _setConfigSettings() async => _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(hours: 12),
        ),
      );
  //some times the we cannot fetch the data from the server due to network issue. in that case we use this function
  /*Future<void> _setDefaults() async => _remoteConfig.setDefaults(
        const {
          FirebaseRemoteConfigKeys.whatsapNumber:
              'The Phonenumber goes here from the local default enbling while creating the parameter',
              FirebaseRemoteConfigKeys.message : '';
        },
      );*/

  Future<void> fetchAndActivate() async {
    bool updated = await _remoteConfig.fetchAndActivate();

    if (updated) {
      debugPrint('The config has been updated.');
    } else {
      debugPrint('The config is not updated..');
    }
  }
}

class FirebaseRemoteConfigKeys {
  static const String whatsapNumber = 'whatsap_number';
  static const String message = 'what_message';
}
