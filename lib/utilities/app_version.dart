import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersion {
  static Future<String> getCurrentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  static Future<String> getCurrentBuildNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.buildNumber;
  }

  static Future<bool> isUpdateAvailable({
    required String latestVersion,
    required int latestBuild,
  }) async {
    List<String> currentParts = (await getCurrentVersion()).split('.');
    List<String> latestParts = latestVersion.split('.');

    int currentBuild = int.parse(await getCurrentBuildNumber());

    debugPrint("Latest Version: $currentParts Current Version: $latestParts");

    for (int i = 0; i < 3; i++) {
      int current = int.parse(currentParts[i]);
      int latest = int.parse(latestParts[i]);

      if (latest > current) return true;
      if (latest < current) return false;
    }

    // If version numbers are equal, compare build numbers
    return latestBuild > currentBuild;
  }
}
