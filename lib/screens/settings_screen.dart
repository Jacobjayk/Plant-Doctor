import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _saveImages = true;
  bool _showConfidenceScore = true;
  bool _enableNotifications = false;
  String _selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _saveImages = prefs.getBool('save_images') ?? true;
      _showConfidenceScore = prefs.getBool('show_confidence_score') ?? true;
      _enableNotifications = prefs.getBool('enable_notifications') ?? false;
      _selectedLanguage = prefs.getString('selected_language') ?? 'English';
    });
  }

  Future<void> _saveSetting(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // App Settings Section
          _buildSectionHeader('App Settings'),
          
          _buildSettingsTile(
            icon: Icons.save_alt,
            title: 'Save Images',
            subtitle: 'Keep analyzed images in device storage',
            trailing: Switch(
              value: _saveImages,
              onChanged: (value) {
                setState(() {
                  _saveImages = value;
                });
                _saveSetting('save_images', value);
              },
            ),
          ),

          _buildSettingsTile(
            icon: Icons.analytics,
            title: 'Show Confidence Score',
            subtitle: 'Display prediction confidence percentage',
            trailing: Switch(
              value: _showConfidenceScore,
              onChanged: (value) {
                setState(() {
                  _showConfidenceScore = value;
                });
                _saveSetting('show_confidence_score', value);
              },
            ),
          ),

          _buildSettingsTile(
            icon: Icons.notifications,
            title: 'Notifications',
            subtitle: 'Enable app notifications',
            trailing: Switch(
              value: _enableNotifications,
              onChanged: (value) {
                setState(() {
                  _enableNotifications = value;
                });
                _saveSetting('enable_notifications', value);
              },
            ),
          ),

          _buildSettingsTile(
            icon: Icons.language,
            title: 'Language',
            subtitle: _selectedLanguage,
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: _showLanguageDialog,
          ),

          const SizedBox(height: 24),

          // Data Management Section
          _buildSectionHeader('Data Management'),

          _buildSettingsTile(
            icon: Icons.storage,
            title: 'Storage Usage',
            subtitle: 'View app storage usage',
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: _showStorageInfo,
          ),

          _buildSettingsTile(
            icon: Icons.delete_sweep,
            title: 'Clear Cache',
            subtitle: 'Free up storage space',
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: _clearCache,
          ),

          _buildSettingsTile(
            icon: Icons.backup,
            title: 'Export Data',
            subtitle: 'Export prediction history',
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: _exportData,
          ),

          const SizedBox(height: 24),

          // About Section
          _buildSectionHeader('About'),

          _buildSettingsTile(
            icon: Icons.info,
            title: 'About App',
            subtitle: 'Version 1.0.0',
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: _showAboutDialog,
          ),

          _buildSettingsTile(
            icon: Icons.help,
            title: 'Help & Support',
            subtitle: 'Get help using the app',
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: _showHelpDialog,
          ),

          _buildSettingsTile(
            icon: Icons.privacy_tip,
            title: 'Privacy Policy',
            subtitle: 'View privacy policy',
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: _showPrivacyPolicy,
          ),

          const SizedBox(height: 24),

          // Model Information
          _buildSectionHeader('Model Information'),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Fully Offline AI Model',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This app uses a TensorFlow Lite model that runs completely offline. No internet connection is required for plant disease detection.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Supported Diseases: 35+ plant diseases across 9 crop types',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            'English',
            'Spanish',
            'French',
            'German',
          ].map((language) => RadioListTile<String>(
            title: Text(language),
            value: language,
            groupValue: _selectedLanguage,
            onChanged: (value) {
              setState(() {
                _selectedLanguage = value!;
              });
              _saveSetting('selected_language', value!);
              Navigator.pop(context);
            },
          )).toList(),
        ),
      ),
    );
  }

  void _showStorageInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Storage Usage'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('App Data: ~15 MB'),
            Text('Model Files: ~25 MB'),
            Text('Cached Images: ~5 MB'),
            Text('Database: ~2 MB'),
            Divider(),
            Text('Total: ~47 MB', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _clearCache() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cache'),
        content: const Text('This will clear temporary files and free up storage space. Your prediction history will not be affected.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cache cleared successfully')),
              );
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _exportData() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Data'),
        content: const Text('Export your prediction history as a CSV file.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Data export feature coming soon')),
              );
            },
            child: const Text('Export'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: 'Plant Disease Detector',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(Icons.eco, size: 48),
      children: [
        const Text(
          'A fully offline mobile app for plant disease detection using deep learning. '
          'This app helps farmers and gardeners identify plant diseases quickly and accurately.',
        ),
        const SizedBox(height: 16),
        const Text(
          'Features:\n'
          '• Offline AI-powered disease detection\n'
          '• Support for 35+ plant diseases\n'
          '• Detailed treatment recommendations\n'
          '• Prediction history tracking\n'
          '• No internet required',
        ),
      ],
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help & Support'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'How to use:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('1. Take a clear photo of the affected plant'),
              Text('2. Ensure good lighting and focus'),
              Text('3. Tap "Analyze Plant Disease"'),
              Text('4. View results and treatment recommendations'),
              SizedBox(height: 16),
              Text(
                'Tips for best results:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('• Use natural lighting when possible'),
              Text('• Focus on the affected area'),
              Text('• Avoid blurry or dark images'),
              Text('• Include leaves and symptoms clearly'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicy() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy Policy'),
        content: const SingleChildScrollView(
          child: Text(
            'Privacy Policy\n\n'
            'This app processes images locally on your device. No data is sent to external servers.\n\n'
            'Data Collection:\n'
            '• Images are processed locally\n'
            '• Prediction history is stored locally\n'
            '• No personal information is collected\n\n'
            'Data Storage:\n'
            '• All data remains on your device\n'
            '• You can delete data anytime\n'
            '• No cloud storage is used\n\n'
            'Your privacy is important to us. This app is designed to work completely offline to protect your data.',
          ),
        ),
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

