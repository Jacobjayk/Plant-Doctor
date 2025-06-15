import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:plant_doctor/services/ml_service.dart';
import 'package:plant_doctor/screens/camera_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant Doctor'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Consumer<MLService>(
        builder: (context, mlService, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Welcome section
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.eco,
                            size: 64,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Welcome to Plant Doctor',
                            style: Theme.of(context).textTheme.headlineSmall,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Detect plant diseases instantly using AI. Take a photo or upload an image to get started.',
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Status indicator
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(
                            mlService.isInitialized 
                              ? Icons.check_circle 
                              : Icons.error,
                            color: mlService.isInitialized 
                              ? Colors.green 
                              : Colors.red,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              mlService.isInitialized 
                                ? 'AI Model Ready - Fully Offline'
                                : 'AI Model Loading...',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Action buttons
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildActionButton(
                        context,
                        icon: Icons.camera_alt,
                        title: 'Take Photo',
                        subtitle: 'Use camera to capture plant image',
                        onTap: mlService.isInitialized 
                          ? () => _navigateToCamera(context, true)
                          : null,
                      ),
                      
                      const SizedBox(height: 16),
                      
                      _buildActionButton(
                        context,
                        icon: Icons.photo_library,
                        title: 'Choose from Gallery',
                        subtitle: 'Select existing image from gallery',
                        onTap: mlService.isInitialized 
                          ? () => _navigateToCamera(context, false)
                          : null,
                      ),
                    ],
                  ),
                  
                  // Quick stats
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Supported Crops',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: [
                              'Apple', 'Tomato', 'Corn', 'Grape', 'Potato', 
                              'Pepper', 'Cherry', 'Peach', 'Strawberry'
                            ].map((crop) => Chip(
                              label: Text(crop),
                              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                            )).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback? onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: onTap != null 
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: onTap != null 
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: onTap != null ? null : Colors.grey,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: onTap != null ? null : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: onTap != null 
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToCamera(BuildContext context, bool useCamera) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraScreen(useCamera: useCamera),
      ),
    );
  }
}

