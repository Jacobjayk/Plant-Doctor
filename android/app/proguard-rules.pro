# Keep TensorFlow Lite GPU delegate classes to prevent R8 from removing them
-keep class org.tensorflow.lite.** { *; }
-keep class org.tensorflow.** { *; }
-dontwarn org.tensorflow.**
