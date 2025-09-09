import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../constants/app_configs.dart';
import '../../../network/api_client.dart';
import '../../../services/shared_preference_service.dart';
import '../../base/model/base_request.dart';
import '../../base/model/base_response.dart';
import '../../base/repository/base_repository.dart';
import '../model/login_request.dart';
import '../model/login_response.dart';

class LoginRepository extends BaseRepository {
  LoginRepository({
    required ApiClient apiClient,
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
    required SharedPreferenceService sharedPreferenceService,
  }) : super(
         apiClient: apiClient,
         firebaseAuth: firebaseAuth,
         googleSignIn: googleSignIn,
         sharedPreferenceService: sharedPreferenceService,
       );

  Future<LoginResponse> loginWithFirebaseAuthEmail(LoginRequest request) async {
    try {
      final credential = await firebaseAuth!.signInWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );
      debugPrint("credential: ${credential.user!.email}");
      return LoginResponse.fromFirebaseAuth(credential.user);
    } catch (e) {
      rethrow;
    }
  }

  Future<BaseResponse<LoginResponse>> loginWithEmail(
    LoginRequest request,
  ) async {
    final response = await apiClient!
        .loginWithEmail(BaseRequest(data: request))
        .catchError((error) => throw Exception(error));
    return response;
  }

  Future<void> logoutFirebaseAuth() async {
    await firebaseAuth!.signOut();
  }

  Future<LoginResponse> loginInWithGoogle() async {
    await googleSignIn!.initialize(
      serverClientId: AppConfigs.firebaseWebClientId,
    );

    try {
      var user = await googleSignIn!.authenticate();

      // if (user == null) throw Exception();

      final auth = await user.authentication;
      final googleCredential = GoogleAuthProvider.credential(
        idToken: auth.idToken,
      );

      var credential = await firebaseAuth!.signInWithCredential(
        googleCredential,
      );
      return LoginResponse.fromFirebaseAuth(credential.user);
    } catch (e) {
      print('Google Sign-In error: $e');
      rethrow;
    }
  }

  Future<void> logOutGoogleAuth() async {
    await googleSignIn!.signOut();
    await firebaseAuth!.signOut();
  }
}
