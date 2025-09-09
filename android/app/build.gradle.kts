import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.jasmine.flutter_bloc_cubit"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.jasmine.flutter_bloc_cubit"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("demo") {
            keyAlias = keystoreProperties["demo.keyAlias"] as String
            keyPassword = keystoreProperties["demo.keyPassword"] as String
            storeFile = keystoreProperties["demo.storeFile"]?.let { file(it) }
            storePassword = keystoreProperties["demo.storePassword"] as String
        }
        create("release") {
            keyAlias = keystoreProperties["release.keyAlias"] as String
            keyPassword = keystoreProperties["release.keyPassword"] as String
            storeFile = keystoreProperties["release.storeFile"]?.let { file(it) }
            storePassword = keystoreProperties["release.storePassword"] as String
        }
    }

//    buildTypes {
//        release {
//            // TODO: Add your own signing config for the release build.
//            // Signing with the debug keys for now, so `flutter run --release` works.
//            signingConfig = signingConfigs.getByName("debug")
//        }
//    }

    flavorDimensions += "default"
    productFlavors {
        create("production") {
            dimension = "default"
            resValue(
                type = "string",
                name = "app_name",
                value = "Flutter Bloc Cubit")
            signingConfig = signingConfigs.getByName("release")
        }
        create("demo") {
            dimension = "default"
            resValue(
                type = "string",
                name = "app_name",
                value = "Flutter Bloc Cubit (Demo)")
            applicationIdSuffix = ".demo"
            signingConfig = signingConfigs.getByName("demo")
        }
    }
}

flutter {
    source = "../.."
}
