import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class MLService {
  Interpreter? _interpreter;
  List<String>? _labels;
  bool _isInitialized = false;

  // Model configuration
  static const String _modelPath = 'assets/models/plant_disease.tflite';
  static const int _inputSize = 224; // Common input size for plant disease models
  static const int _numChannels = 3; // RGB
  
  bool get isInitialized => _isInitialized;

  Future<void> initialize() async {
    try {
      // Load the TensorFlow Lite model
      _interpreter = await Interpreter.fromAsset(_modelPath);
      
      // Initialize labels - these are the disease classes the model can predict
      _labels = _getPlantDiseaseLabels();
      
      _isInitialized = true;
      print('ML Service initialized successfully');
    } catch (e) {
      print('Error initializing ML Service: $e');
      _isInitialized = false;
    }
  }

  Future<Map<String, dynamic>?> predictDisease(String imagePath) async {
    if (!_isInitialized || _interpreter == null) {
      throw Exception('ML Service not initialized');
    }

    try {
      // Print input and output tensor shapes for debugging
      final inputShape = _interpreter!.getInputTensor(0).shape;
      final outputShape = _interpreter!.getOutputTensor(0).shape;
      print('Model input shape: $inputShape');
      print('Model output shape: $outputShape');

      // Load and preprocess the image
      final imageBytes = await File(imagePath).readAsBytes();
      final processedImage = await _preprocessImage(imageBytes, inputShape);

      // Prepare input and output tensors
      final input = processedImage;
      final numClasses = outputShape.last;
      final output = List.filled(numClasses, 0.0).reshape([1, numClasses]);

      // Run inference
      _interpreter!.run(input, output);

      // Process results
      final predictions = output[0] as List<double>;
      final maxIndex = _getMaxIndex(predictions);
      final maxConfidence = predictions[maxIndex];

      final labels = _getPlantDiseaseLabels();
      String diseaseName = (maxIndex < labels.length) ? labels[maxIndex] : 'Unknown';
      String diseaseId = _getDiseaseId(diseaseName);

      // Confidence threshold (0.55 = 50%)
      const double confidenceThreshold = 0.55;
      if (maxConfidence < confidenceThreshold) {
        diseaseName = 'Unknown or Not a Plant Disease';
        diseaseId = 'unknown';
      }

      print('Predicted label: $diseaseName');
      print('Generated diseaseId: $diseaseId');
      
      return {
        'disease_name': diseaseName,
        'confidence': maxConfidence,
        'disease_id': diseaseId,
        'all_predictions': Map.fromIterables(
          labels.length == predictions.length ? labels : List.generate(predictions.length, (i) => 'Class $i'),
          predictions,
        ),
      };
    } catch (e) {
      print('Error during prediction: $e');
      return null;
    }
  }

  // Update _preprocessImage to accept inputShape and return correct type
  Future<dynamic> _preprocessImage(Uint8List imageBytes, List<int> inputShape) async {
    // Decode the image
    img.Image? image = img.decodeImage(imageBytes);
    if (image == null) {
      throw Exception('Failed to decode image');
    }

    // Force to 128x128x3 as required by your model
    final height = 128;
    final width = 128;
    final channels = 3;
    print('Resizing to width: $width, height: $height, channels: $channels');

    // Resize image to model input size
    img.Image resizedImage = img.copyResize(
      image,
      width: width,
      height: height,
    );

    // Prepare Float32List for model input (NO normalization, just like your Python code)
    final input = Float32List(width * height * channels);
    int index = 0;
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final pixel = resizedImage.getPixel(x, y);
        input[index++] = pixel.r.toDouble();
        input[index++] = pixel.g.toDouble();
        input[index++] = pixel.b.toDouble();
      }
    }

    print('Actual input length: ${input.length}');

    // Reshape to [1, height, width, channels]
    return input.reshape([1, height, width, channels]);
  }

  int _getMaxIndex(List<double> predictions) {
    double maxValue = predictions[0];
    int maxIndex = 0;
    
    for (int i = 1; i < predictions.length; i++) {
      if (predictions[i] > maxValue) {
        maxValue = predictions[i];
        maxIndex = i;
      }
    }
    return maxIndex;
  }
  List<String> _getPlantDiseaseLabels() {
    return [
      // Copy-paste the output of print(class_names) from your Python code here, as a Dart list of strings, in the same order.
      // For example:
      'Apple___Apple_scab',
      'Apple___Black_rot',
      'Apple___Cedar_apple_rust',
      'Apple___healthy',
      'Blueberry___healthy',
      'Cherry_(including_sour)___Powdery_mildew',
      'Cherry_(including_sour)___healthy',
      'Corn_(maize)___Cercospora_leaf_spot Gray_leaf_spot',
      'Corn_(maize)___Common_rust_',
      'Corn_(maize)___Northern_Leaf_Blight',
      'Corn_(maize)___healthy',
      'Grape___Black_rot',
      'Grape___Esca_(Black_Measles)',
      'Grape___Leaf_blight_(Isariopsis_Leaf_Spot)',
      'Grape___healthy',
      'Orange___Haunglongbing_(Citrus_greening)',
      'Peach___Bacterial_spot',
      'Peach___healthy',
      'Pepper,_bell___Bacterial_spot',
      'Pepper,_bell___healthy',
      'Potato___Early_blight',
      'Potato___Late_blight',
      'Potato___healthy',
      'Raspberry___healthy',
      'Soybean___healthy',
      'Squash___Powdery_mildew',
      'Strawberry___Leaf_scorch',
      'Strawberry___healthy',
      'Tomato___Bacterial_spot',
      'Tomato___Early_blight',
      'Tomato___Late_blight',
      'Tomato___Leaf_Mold',
      'Tomato___Septoria_leaf_spot',
      'Tomato___Spider_mites',
      'Tomato___Target_Spot',
      'Tomato___Tomato_Yellow_Leaf_Curl_Virus',
      'Tomato___Tomato_mosaic_virus',
      'Tomato___healthy',
    ];
  }

  String _getDiseaseId(String diseaseName) {
    // Convert model label to database id format
    // Example: 'Apple___Cedar_apple_rust' -> 'apple_cedar_apple_rust'
    return diseaseName
        .toLowerCase()
        .replaceAll(RegExp(r'[\(\),\-]'), '') // remove parentheses, commas, hyphens
        .replaceAll('___', '_')
        .replaceAll('__', '_')
        .replaceAll(' ', '_');
  }

  void dispose() {
    _interpreter?.close();
    _isInitialized = false;
  }
}

