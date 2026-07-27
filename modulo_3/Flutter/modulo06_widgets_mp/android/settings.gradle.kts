pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        val propertiesFile = java.io.File(settingsDir, "local.properties")
        if (propertiesFile.exists()) {
            propertiesFile.reader(charset("UTF-8")).use { properties.load(it) }
        }
        val sdkPath = properties.getProperty("flutter.sdk")
        requireNotNull(sdkPath) { "flutter.sdk not set in local.properties" }
        sdkPath
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.6.0" apply false
    id("org.jetbrains.kotlin.android") version "1.9.22" apply false
}

include(":app")
