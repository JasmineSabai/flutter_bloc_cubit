import 'package:firebase_auth/firebase_auth.dart';

import '../../../constants/app_enum.dart';
import '../../../constants/response_result.dart';
import '../../../dto/user_data.dart';
import '../../base/base_cubit.dart';
import '../../base/model/base_response.dart';
import '../model/login_response.dart';
import '../repositories/login_repository.dart';

class LoginGoogleCubit extends BaseCubit<LoginResponse> {
  final LoginRepository loginRepository;

  LoginGoogleCubit(this.loginRepository);

  Future<void> loginWithGoogle() async {
    emitLoading();
    try {
      final response = await loginRepository.loginInWithGoogle();

      var userData = UserData(profileUrl: response.profileUrl, name: response.name, email: response.email);
      // Store user as old user
      loginRepository.sharedPreferenceService!.saveBoolData(key: PreferenceDataName.isOldUser.name, value: true);
      loginRepository.sharedPreferenceService!.saveJsonData(key: PreferenceDataName.userData.name, value: userData);

      handleResponse(
        BaseResponse(
          responseCode: ResponseResult.success.code,
          responseMessage: ResponseResult.success.message,
          data: response,
        ),
      );
    } on FirebaseAuthException catch (e) {
      handleResponse(
        BaseResponse(responseCode: e.code, responseMessage: e.message ?? ''),
      );
    } catch (e) {
      emitApiFailure(e.toString());
    }
  }

  Future<void> logoutWithGoogle() async {
    emitLoading();
    try {
      loginRepository.logOutGoogleAuth().then((value) {
        // clear user data
        loginRepository.sharedPreferenceService!.clear();

        handleResponse(
          BaseResponse(
            responseCode: ResponseResult.success.code,
            responseMessage: ResponseResult.success.message,
            data: null,
          ),
        );
      });
    } catch (e) {
      emitApiFailure(e.toString());
    }
  }
}
