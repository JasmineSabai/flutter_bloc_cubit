import 'package:flutter/foundation.dart';

import '../../../constants/app_enum.dart';
import '../../../dto/update_version.dart';
import '../../../utilities/app_version.dart';
import '../../base/base_cubit.dart';
import '../repositories/splash_repository.dart';

class UpdateVersionCubit extends BaseCubit<UpdateVersion> {
  final SplashRepository splashRepository;

  UpdateVersionCubit(this.splashRepository) : super();

  void fetchUpdateVersion() async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      splashRepository.getUpdateVersion().then((version) {
        debugPrint("Version: ${version.versionName}");

        AppVersion.isUpdateAvailable(
          latestVersion: version.versionName,
          latestBuild: version.versionCode,
        ).then((result) {
          if (!result) {
            emitDataSuccess(version);
          } else {
            emitDataFailure(version, '');
          }
        });
      });
    } catch (e) {
      emitDataFailure(null, e.toString());
    }
  }
}
