enum AppEnvironment { demo, production, staging }

enum ConnectivityStatus { connected, disconnected }

enum NetworkStatus { initial, loading, success, failure, tokenExpired }

enum PreferenceDataName { isOldUser, isBiometricEnabled, userData }

// FireStore Collection

enum FireStoreNames { adsItems, ads, updateVersion , env }
extension FireStoreNameLabel on FireStoreNames {
  String get displayName {
    switch (this) {
      case FireStoreNames.adsItems:
        return 'ad_items';
      case FireStoreNames.env:
        return 'env';
      case FireStoreNames.ads:
        return 'ads_';
      case FireStoreNames.updateVersion:
        return "update_version";
    }
  }
}
