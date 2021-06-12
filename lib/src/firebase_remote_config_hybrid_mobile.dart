part of firebase_remote_config_hybrid_platform_interface;

class FirebaseRemoteConfigMobile extends FirebaseRemoteConfigPlatformInterface {
  FirebaseRemoteConfigMobile._(core.RemoteConfig platformInstance) : _instance = platformInstance;
  core.RemoteConfig _instance;

  @override
  Map<String, PlatformRemoteConfigValue> getAll() {
    Map<String, core.RemoteConfigValue> coreResult = _instance?.getAll();
    if (coreResult == null) return null;
    Map<String, PlatformRemoteConfigValue> pluginResult = {};
    for (String key in coreResult.keys) {
      pluginResult[key] = _coreConfigValueToPlugin(coreResult[key]);
    }
    return pluginResult;
  }

  @override
  bool getBool(String key) {
    return _instance?.getBool(key);
  }

  @override
  double getDouble(String key) {
    return _instance?.getDouble(key);
  }

  @override
  int getInt(String key) {
    return _instance?.getInt(key);
  }

  @override
  String getString(String key) {
    return _instance?.getString(key);
  }

  @override
  PlatformRemoteConfigValue getValue(String key) {
    return _coreConfigValueToPlugin(_instance?.getValue(key));
  }

  @override
  Future<bool> activateFetched() async {
    return await _instance?.fetchAndActivate();
  }

  @override
  Future<void> fetch({Duration expiration: const Duration(hours: 12)}) async {
    await _instance?.fetch();
  }

  @override
  DateTime get lastFetchTime => _instance?.lastFetchTime;

  @override
  LastFetchStatus get lastFetchStatus => _statusFromCore(_instance?.lastFetchStatus);

  PlatformRemoteConfigValue _coreConfigValueToPlugin(core.RemoteConfigValue coreValue) {
    return coreValue == null
        ? null
        : PlatformRemoteConfigValue(
            asBool: coreValue.asBool,
            asDouble: coreValue.asDouble,
            asInt: coreValue.asInt,
            asString: coreValue.asString,
            getSource: () => _valueSourceFromCore(coreValue.source),
          );
  }

  LastFetchStatus _statusFromCore(core.RemoteConfigFetchStatus status) {
    switch (status) {
      case core.RemoteConfigFetchStatus.failure:
        return LastFetchStatus.failure;
      case core.RemoteConfigFetchStatus.noFetchYet:
        return LastFetchStatus.noFetchYet;
      case core.RemoteConfigFetchStatus.success:
        return LastFetchStatus.success;
      case core.RemoteConfigFetchStatus.throttle:
        return LastFetchStatus.throttled;
      default:
        return null;
    }
  }

  ValueSource _valueSourceFromCore(core.ValueSource source) {
    switch (source) {
      case core.ValueSource.valueDefault:
        return ValueSource.valueDefault;
      case core.ValueSource.valueRemote:
        return ValueSource.valueRemote;
      case core.ValueSource.valueStatic:
        return ValueSource.valueStatic;
      default:
        return null;
    }
  }
}
