# firebase_remote_config_hybrid_platform_interface

A common platform interface for the [`firebase_remote_config_hybrid`](https://github.com/JohnMusleh/firebase_remote_config_hybrid/tree/master/firebase_remote_config_hybrid) plugin.

This interface allows platform-specific implementations of the `firebase_remote_config_hybrid`
plugin, as well as the plugin itself, to ensure they are supporting the
same interface.

# Usage

To implement a new platform-specific implementation of `firebase_remote_config_hybrid`, extend
[`FirebaseRemoteConfigPlatformInterface`](https://github.com/JohnMusleh/firebase_remote_config_hybrid/tree/master/firebase_remote_config_hybrid_platform_interface) with an implementation that performs the
platform-specific behavior, and when you register your plugin, set the default
`FirebaseRemoteConfigPlatformInterface` by calling
`FirebaseRemoteConfigPlatformInterface.instance = MyFirebaseRemoteConfig()`.
