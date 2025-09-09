import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../constants/app_enum.dart';
import '../../../constants/app_environments.dart';
import '../../../dto/ads_item.dart';
import '../../../dto/update_version.dart';
import '../../base/repository/base_repository.dart';

class SplashRepository extends BaseRepository{

  SplashRepository({
    required FirebaseFirestore fireStore,
  }) : super(firestore: fireStore);

  Future<List<AdsItem>> getAdsItems() async {
    final snapshot = await firestore!
        .collection(FireStoreNames.adsItems.displayName)
        .doc(FireStoreNames.env.displayName)
        .collection(EnvironmentConfig.current.name)
        .get();
    var data = snapshot.docs.map((doc) {
      return AdsItem.fromMap(doc.data());
    }).toList();
    return data;
  }

  Future<UpdateVersion> getUpdateVersion() async {
    final snapshot = await firestore!
        .collection(FireStoreNames.updateVersion.displayName)
        .doc(EnvironmentConfig.current.name)
        .get();

    if (snapshot.exists) {
      return UpdateVersion.fromDoc(snapshot);
    }
    return UpdateVersion(versionName: "", versionCode: 0, isForce: false);
  }
}
