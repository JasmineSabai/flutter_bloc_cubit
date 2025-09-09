import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../network/api_client.dart';
import '../../../services/shared_preference_service.dart';
import '../model/base_response.dart';

abstract class BaseRepository {
  final ApiClient? apiClient;
  final FirebaseAuth? firebaseAuth;
  final FirebaseFirestore? firestore;
  final GoogleSignIn? googleSignIn;
  final SharedPreferenceService? sharedPreferenceService;

  BaseRepository({this.apiClient, this.firebaseAuth, this.firestore, this.googleSignIn, this.sharedPreferenceService});

  /// Common API call wrapper
  Future<T> safeApiCall<T>(Future<BaseResponse<T>> Function() apiCall) async {
    try {
      final response = await apiCall();
      if (response.responseCode == "200" && response.data != null) {
        return response.data!;
      } else {
        throw Exception(response.responseMessage);
      }
    } catch (e) {
      rethrow;
    }
  }
}
