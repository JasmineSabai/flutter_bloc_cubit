import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../network/api_client.dart';
import '../scenes/splash_screen/repositories/splash_repository.dart';
import '../scenes/login/repositories/login_repository.dart';
import '../services/shared_preference_service.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FirebaseAuth>(
          create: (_) => FirebaseAuth.instance,
        ),
        RepositoryProvider<FirebaseFirestore>(
          create: (_) => FirebaseFirestore.instance,
        ),
        RepositoryProvider<GoogleSignIn>(
          create: (_) => GoogleSignIn.instance,
        ),
        RepositoryProvider<SharedPreferenceService>(
          create: (_) => SharedPreferenceService(),
        ),
        RepositoryProvider<ApiClient>(
          create: (_) => ApiClient(Dio()),
        ),
        // Repositories
        RepositoryProvider<LoginRepository>(
          create: (context) => LoginRepository(
            apiClient: context.read<ApiClient>(),
            firebaseAuth: context.read<FirebaseAuth>(),
            googleSignIn: context.read<GoogleSignIn>(),
            sharedPreferenceService: context.read<SharedPreferenceService>(),
          ),
        ),
        RepositoryProvider<SplashRepository>(
          create: (context) => SplashRepository(
            fireStore: context.read<FirebaseFirestore>(),
          ),
        ),
      ],
      child: child,
    );
  }
}