import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app/app_bloc_provider.dart';
import 'app/app_provider.dart';
import 'constants/app_configs.dart';
import 'constants/app_environments.dart';
import 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var app = await Firebase.initializeApp(
    options: EnvironmentConfig.currentFirebaseOptions,
  );
  FirebaseAuth.instanceFor(app: app);

  AppConfigs.loadAppConfigs(environment: EnvironmentConfig.current);
  runApp(AppProviders(child: AppBlocProviders(child: MyApp())));
}
