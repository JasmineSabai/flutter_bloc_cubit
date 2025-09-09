import 'package:firebase_auth/firebase_auth.dart';

class LoginResponse {
  final String id;
  final String profileUrl;
  final String name;
  final String email;

  LoginResponse({
    required this.id,
    required this.profileUrl,
    required this.name,
    required this.email,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      id: json['id'],
      profileUrl: json['profileUrl'],
      name: json['name'],
      email: json['email'],
    );
  }

  factory LoginResponse.fromFirebaseAuth(User? user) {
    return LoginResponse(
      id: user?.uid ?? '',
      profileUrl: user?.photoURL ?? '',
      name: user?.displayName ?? '',
      email: user?.email ?? '',
    );
  }
}
