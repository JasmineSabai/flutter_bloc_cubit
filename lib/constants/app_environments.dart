import 'package:firebase_core/firebase_core.dart';

import 'app_enum.dart';
import '../firebase/firebase_options_demo.dart' as demo_options;
import '../firebase/firebase_options.dart' as prod_options;

class EnvironmentConfig {
  static AppEnvironment get current {
    const env = String.fromEnvironment('FLAVOR', defaultValue: 'demo');
    return switch (env) {
      'production' => AppEnvironment.production,
      'demo' => AppEnvironment.demo,
      _ => AppEnvironment.demo,
    };
  }

  static FirebaseOptions get currentFirebaseOptions {
    const env = String.fromEnvironment('FLAVOR', defaultValue: 'demo');
    return switch (env) {
      'production' => prod_options.DefaultFirebaseOptions.currentPlatform,
      'demo' => demo_options.DefaultFirebaseOptions.currentPlatform,
      _ => demo_options.DefaultFirebaseOptions.currentPlatform,
    };
  }


  static bool get isDemo {
    return current == AppEnvironment.demo;
  }

  static bool get isProd {
    return current == AppEnvironment.production;
  }
}
