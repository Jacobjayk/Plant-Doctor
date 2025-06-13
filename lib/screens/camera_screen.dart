import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:plant_disease_detector/services/ml_service.dart';
import 'package:plant_disease_detector/services/database_service.dart';
import 'package:plant_disease_detector/models/plant_disease.dart';
import 'package:plant_disease_detector/screens/prediction_result_screen.dart';

class CameraScreen extends StatefulWidget {
  final bool useCamera;

  const CameraScreen({super.key, required this.useCamera});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _selectedImage;
  bool _isProcessing = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Automatically open camera or gallery on screen open
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.useCamera) {
        _captureImage();
      } else {
        _selectFromGallery();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.useCamera ? 'Take Photo' : 'Select Image'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image preview section
            Expanded(
              flex: 3,
              child: Card(
                child: _selectedImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          _selectedImage!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.shade100,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              widget.useCamera ? Icons.camera_alt : Icons.photo_library,
                              size: 64,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _selectedImage == null
                                  ? 'No image selected'
                                  : 'Processing...',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 16),

            // Action buttons section
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  if (_selectedImage != null && !_isProcessing) ...[
                    ElevatedButton.icon(
                      onPressed: _analyzeImage,
                      icon: const Icon(Icons.analytics),
                      label: const Text('Analyze Plant Disease'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],

                  if (_isProcessing) ...[
                    const LinearProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(
                      'Analyzing image...',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                  ],

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _isProcessing ? null : _captureImage,
                          icon: const Icon(Icons.camera_alt),
                          label: const Text('Camera'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _isProcessing ? null : _selectFromGallery,
                          icon: const Icon(Icons.photo_library),
                          label: const Text('Gallery'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _captureImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      _showErrorDialog('Failed to capture image: $e');
    }
  }

  Future<void> _selectFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      _showErrorDialog('Failed to select image: $e');
    }
  }

  Future<void> _analyzeImage() async {
    if (_selectedImage == null) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      final mlService = Provider.of<MLService>(context, listen: false);
      final databaseService = Provider.of<DatabaseService>(context, listen: false);

      // Run prediction
      final result = await mlService.predictDisease(_selectedImage!.path);

      if (result != null) {
        // Create prediction result
        final prediction = PredictionResult(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          imagePath: _selectedImage!.path,
          diseaseId: result['disease_id'],
          diseaseName: result['disease_name'],
          confidence: result['confidence'],
          timestamp: DateTime.now(),
        );

        // Save to database
        await databaseService.savePrediction(prediction);

        // Navigate to results screen
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PredictionResultScreen(
                prediction: prediction,
                image: _selectedImage!,
              ),
            ),
          );
        }
      } else {
        _showErrorDialog('Failed to analyze image. Please try again.');
      }
    } catch (e) {
      _showErrorDialog('Error during analysis: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

