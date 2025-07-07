# Keep TFLite GPU classes
-keep class org.tensorflow.** { *; }
-dontwarn org.tensorflow.**

# Optional: Also keep Flutter plugin classes
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugins.** { *; }

# Prevent R8 from stripping split install code that may be referenced
-keep class com.google.android.play.** { *; }
-dontwarn com.google.android.play.**