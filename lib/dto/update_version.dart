import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateVersion {
  final String? iosUrl;
  final String? androidUrl;
  final String versionName;
  final int versionCode;
  final bool isForce;

  UpdateVersion({this.iosUrl, this.androidUrl, required this.versionName, required this.versionCode, required this.isForce});

  factory UpdateVersion.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return UpdateVersion(
      iosUrl: data['ios_url'] ?? '',
      androidUrl: data['android_url'] ?? '',
      versionName: data['version_name'] ?? '',
      versionCode: data['version_code'] ?? '',
      isForce: data['is_force'] ?? '',
    );
  }
}
