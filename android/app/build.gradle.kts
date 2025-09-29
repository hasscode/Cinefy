import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.cinefy_movie_app"
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
        applicationId = "com.example.cinefy_movie_app"
        minSdk = 23
        targetSdk = 34
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // نقرأ بيانات التوقيع من key.properties
    val keystoreProperties = Properties().apply {
        val keystorePropertiesFile = rootProject.file("key.properties")
        if (keystorePropertiesFile.exists()) {
            load(FileInputStream(keystorePropertiesFile))
        }
    }

    signingConfigs {
        create("release") {
            storeFile = keystoreProperties["storeFile"]?.let { file(it.toString()) }
            storePassword = keystoreProperties["storePassword"] as String?
            keyAlias = keystoreProperties["keyAlias"] as String?
            keyPassword = keystoreProperties["keyPassword"] as String?
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")

            // فعلنا ضغط الكود
            isMinifyEnabled = true

            // فعلنا ضغط الصور والملفات غير المستخدمة
            isShrinkResources = true

            // ملفات ProGuard (بتحدد القواعد اللي هتتشال واللي هتفضل)
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

flutter {
    source = "../.."
}
