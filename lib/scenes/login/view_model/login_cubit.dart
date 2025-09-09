import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../../constants/app_enum.dart';
import '../../../constants/response_result.dart';
import '../../../dto/user_data.dart';
import '../../base/base_cubit.dart';
import '../../base/model/base_response.dart';
import '../model/login_request.dart';
import '../model/login_response.dart';
import '../repositories/login_repository.dart';

class LoginCubit extends BaseCubit<LoginResponse> {
  final LoginRepository loginRepository;

  LoginCubit(this.loginRepository);

  Future<bool> get isOldUser => loginRepository.sharedPreferenceService!.loadBoolData(
    key: PreferenceDataName.isOldUser.name,
  );

  Future<UserData> get userData => loginRepository.sharedPreferenceService!.loadJsonData(
    key: PreferenceDataName.userData.name,
  );

  Future<void> loginWithFirebaseAuthEmail(LoginRequest request) async {
    emitLoading();
    try {
      debugPrint("REQUEST: $request");
      final response = await loginRepository.loginWithFirebaseAuthEmail(
        request,
      );

      var userData = UserData(profileUrl: response.profileUrl, name: response.name, email: response.email);
      // Store user as old user
      loginRepository.sharedPreferenceService!.saveBoolData(
        key: PreferenceDataName.isOldUser.name,
        value: true,
      );
      loginRepository.sharedPreferenceService!.saveJsonData(
        key: PreferenceDataName.userData.name,
        value: userData,
      );

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

  Future<void> logoutFirebaseAuth() async {
    emitLoading();
    try {
      loginRepository.logoutFirebaseAuth().then((value) {
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

  Future<void> loginWithEmail(LoginRequest request) async {
    emitLoading();
    try {
      final response = await loginRepository.loginWithEmail(request);
      handleResponse(response);
    } catch (e) {
      emitApiFailure(e.toString());
    }
  }
}
