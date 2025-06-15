import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:plant_doctor/models/plant_disease.dart';
import 'package:plant_doctor/services/database_service.dart';
import 'package:plant_doctor/screens/camera_screen.dart';
import 'package:plant_doctor/main.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PredictionResultScreen extends StatefulWidget {
  final PredictionResult prediction;
  final File image;

  const PredictionResultScreen({
    super.key,
    required this.prediction,
    required this.image,
  });

  @override
  State<PredictionResultScreen> createState() => _PredictionResultScreenState();
}

class _PredictionResultScreenState extends State<PredictionResultScreen> {
  PlantDisease? _diseaseInfo;
  bool _isLoading = true;
  bool _showConfidence = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _loadDiseaseInfo();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _refreshShowConfidence();
  }

  Future<void> _refreshShowConfidence() async {
    final prefs = await SharedPreferences.getInstance();
    final show = prefs.getBool('show_confidence');
    if (show != null && show != _showConfidence) {
      setState(() {
        _showConfidence = show;
      });
    }
  }

  void _reloadSettingsOnNavigation() {
    // Listen for navigation events and reload settings
    ModalRoute.of(context)?.addLocalHistoryEntry(LocalHistoryEntry(onRemove: () {
      // When returning to this screen, reload the settings
      _loadSettings();
    }));
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    // Load the confidence score toggle from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _showConfidence = prefs.getBool('show_confidence') ?? true;
    });
  }

  Future<void> _loadDiseaseInfo() async {
    final databaseService = Provider.of<DatabaseService>(context, listen: false);
    final diseaseInfo = await databaseService.getDiseaseById(widget.prediction.diseaseId);
    
    setState(() {
      _diseaseInfo = diseaseInfo;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analysis Results'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              // Replace root with MainNavigationScreen and Home tab
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const MainNavigationScreen(initialIndex: 0),
                ),
              );
            },
            icon: const Icon(Icons.home),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Image and basic result
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: widget.image.path.isNotEmpty && File(widget.image.path).existsSync()
                                ? Image.file(
                                    widget.image,
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    height: 200,
                                    width: double.infinity,
                                    color: Colors.grey.shade200,
                                    child: Icon(
                                      Icons.image_not_supported,
                                      size: 64,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                          ),
                          const SizedBox(height: 16),
                          // Remove the extra SizedBox when _showConfidence is false
                          if (_showConfidence) ...[
                            _buildConfidenceIndicator(),
                            const SizedBox(height: 16),
                          ],
                          Text(
                            widget.prediction.diseaseName,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          if (_diseaseInfo != null) ...[
                            const SizedBox(height: 8),
                            Text(
                              _diseaseInfo!.scientificName,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey.shade600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Disease information
                  if (_diseaseInfo != null) ...[
                    _buildInfoCard(
                      'Description',
                      _diseaseInfo!.description,
                      Icons.info_outline,
                    ),
                    _buildInfoCard(
                      'Symptoms',
                      _diseaseInfo!.symptoms.join('\n• '),
                      Icons.visibility_outlined,
                    ),
                    _buildInfoCard(
                      'Cultural Management',
                      _diseaseInfo!.culturalManagement.join('\n• '),
                      Icons.agriculture_outlined,
                    ),
                    _buildInfoCard(
                      'Chemical Management',
                      _diseaseInfo!.chemicalManagement.join('\n• '),
                      Icons.science_outlined,
                    ),
                    if (_diseaseInfo!.resistantVarieties.isNotEmpty)
                      _buildInfoCard(
                        'Resistant Varieties',
                        _diseaseInfo!.resistantVarieties.join(', '),
                        Icons.shield_outlined,
                      ),
                  ] else if (widget.prediction.diseaseId == 'unknown') ...[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.help_outline,
                              size: 48,
                              color: Colors.orange,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Not a Plant Disease',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'The uploaded image does not appear to be a supported plant or plant disease. Please try again with a clear image of a plant leaf.',
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ] else ...[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.warning_amber_outlined,
                              size: 48,
                              color: Colors.orange,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Disease information not available',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'The detected disease "${widget.prediction.diseaseName}" was identified, but detailed information is not available in the database.',
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 16),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).popUntil((route) => route.isFirst);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const CameraScreen(useCamera: false),
                              ),
                            );
                          },
                          icon: const Icon(Icons.camera_alt),
                          label: const Text('Analyze Another'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _shareResults,
                          icon: const Icon(Icons.share),
                          label: const Text('Share'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildConfidenceIndicator() {
    final confidence = widget.prediction.confidence;
    final percentage = (confidence * 100).round();
    
    Color confidenceColor;
    String confidenceText;
    
    if (confidence >= 0.8) {
      confidenceColor = Colors.green;
      confidenceText = 'High Confidence';
    } else if (confidence >= 0.6) {
      confidenceColor = Colors.orange;
      confidenceText = 'Medium Confidence';
    } else {
      confidenceColor = Colors.red;
      confidenceText = 'Low Confidence';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: confidenceColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: confidenceColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.analytics,
            color: confidenceColor,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            '$percentage% - $confidenceText',
            style: TextStyle(
              color: confidenceColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String content, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              content.startsWith('•') ? content : '• $content',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  void _shareResults() async {
    final confidence = (widget.prediction.confidence * 100).toStringAsFixed(1);
    final text = '''
Plant Disease Detection Result

Disease: ${widget.prediction.diseaseName}
Confidence: $confidence%
${_diseaseInfo != null ? "Description: ${_diseaseInfo!.description}" : ""}
${_diseaseInfo != null ? "Symptoms: ${_diseaseInfo!.symptoms.join(', ')}" : ""}

Detected using Plant Disease Detector app.
''';

    await Share.shareXFiles(
      [XFile(widget.image.path)],
      text: text,
      subject: 'Plant Disease Detection Result',
    );
  }
}

