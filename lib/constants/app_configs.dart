import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app_enum.dart';

class AppConfigs {
  static Future<void> loadAppConfigs({
    required AppEnvironment environment,
  }) async {
    var envFileName = 'assets/configs/.env.${environment.name}';
    debugPrint("ENVIRONMENT: ${environment.name}");
    try {
      await dotenv.load(fileName: envFileName); // Load environment variables
    } catch (e) {
      debugPrint('Error loading .env file: $e , $envFileName');
      throw Exception('Error loading .env file: $e'); // Print error if any
    }
  }

  static final String appMode = dotenv.get('APP_MODE', fallback: 'demo');
  static final String apiDomain = dotenv.get('API_DOMAIN', fallback: '');
  static final String firebaseWebClientId = dotenv.get('FIREBASE_WEB_CLIENT_ID', fallback: '');
}
