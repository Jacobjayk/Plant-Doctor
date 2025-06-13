# Plant Disease Detector

A fully offline mobile app for plant disease detection using deep learning and Flutter.

## Overview

This mobile application uses TensorFlow Lite to detect plant diseases completely offline. The app can identify 35+ plant diseases across 9 crop types and provides detailed treatment recommendations based on scientific research.

## Features

- **🔬 AI-Powered Detection**: Uses TensorFlow Lite for fast, accurate disease identification
- **📱 Fully Offline**: No internet connection required after installation
- **📸 Camera Integration**: Take photos or select from gallery
- **📊 Detailed Results**: Confidence scores and comprehensive disease information
- **📚 Disease Database**: Extensive database with symptoms, treatments, and management strategies
- **📝 History Tracking**: Save and review previous predictions
- **⚙️ Customizable Settings**: User preferences and app configuration
- **🎯 High Accuracy**: Optimized for prediction speed under 3 seconds

## Supported Crops & Diseases

### Apple
- Apple Scab (Venturia inaequalis)
- Black Rot (Botryosphaeria obtusa)
- Cedar Apple Rust (Gymnosporangium juniperi-virginianae)

### Corn
- Gray Leaf Spot (Cercospora zeae-maydis)
- Common Rust (Puccinia sorghi)
- Northern Leaf Blight (Exserohilum turcicum)

### Tomato
- Bacterial Spot (Xanthomonas complex)
- Early Blight (Alternaria solani)
- Late Blight (Phytophthora infestans)
- Leaf Mold (Passalora fulva)
- Septoria Leaf Spot (Septoria lycopersici)
- Target Spot (Corynespora cassiicola)
- Yellow Leaf Curl Virus (TYLCV)
- Mosaic Virus (ToMV)

### Potato
- Early Blight (Alternaria solani)
- Late Blight (Phytophthora infestans)

### Other Crops
- Cherry Powdery Mildew
- Grape diseases (Black Rot, Esca, Leaf Blight)
- Orange Huanglongbing
- Peach Bacterial Spot
- Pepper Bacterial Spot
- Squash Powdery Mildew
- Strawberry Leaf Scorch

## Technical Specifications

- **Framework**: Flutter 3.24.5
- **ML Engine**: TensorFlow Lite
- **Database**: SQLite
- **Platforms**: Android & iOS
- **Model Size**: ~25MB
- **Prediction Time**: <3 seconds
- **Input Size**: 224x224 RGB images

## Installation & Setup

### Prerequisites

1. **Flutter SDK** (3.24.5 or later)
   ```bash
   flutter --version
   ```

2. **Android Studio** (for Android development)
3. **Xcode** (for iOS development, macOS only)

### Setup Instructions

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd plant_disease_detector
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Verify model files**
   Ensure these files are in `assets/models/`:
   - `plant_disease.tflite`
   - `PlantDiseaseClassifier.mlmodel`

5. **Run the app**
   ```bash
   flutter run
   ```

### Building for Release

#### Android APK
```bash
flutter build apk --release
```

#### iOS IPA
```bash
flutter build ios --release
```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   └── plant_disease.dart
├── screens/                  # UI screens
│   ├── home_screen.dart
│   ├── camera_screen.dart
│   ├── prediction_result_screen.dart
│   ├── history_screen.dart
│   └── settings_screen.dart
├── services/                 # Business logic
│   ├── ml_service.dart
│   └── database_service.dart
├── widgets/                  # Reusable UI components
├── utils/                    # Utility functions
│   └── image_utils.dart
└── data/                     # Static data
    └── disease_data.dart

assets/
├── models/                   # ML model files
│   ├── plant_disease.tflite
│   └── PlantDiseaseClassifier.mlmodel
└── images/                   # App images
```

## Usage Guide

### Taking a Photo
1. Open the app and tap "Take Photo"
2. Capture a clear image of the affected plant
3. Ensure good lighting and focus on diseased areas
4. Tap "Analyze Plant Disease"

### Selecting from Gallery
1. Tap "Choose from Gallery"
2. Select an existing plant image
3. Tap "Analyze Plant Disease"

### Viewing Results
- **Disease Name**: Identified disease with scientific name
- **Confidence Score**: Prediction accuracy (High/Medium/Low)
- **Symptoms**: Detailed symptom descriptions
- **Management**: Cultural and chemical treatment options
- **Resistant Varieties**: Recommended resistant cultivars

### Managing History
- View all previous predictions in the History tab
- Tap any prediction to view detailed results
- Delete individual predictions or clear entire history

## Performance Optimization

### Image Guidelines
- **Resolution**: 1024x1024 pixels maximum
- **Format**: JPG or PNG
- **Lighting**: Natural lighting preferred
- **Focus**: Clear, sharp images
- **Subject**: Include affected leaves/areas

### Battery Optimization
- Model runs efficiently on device
- Minimal background processing
- Optimized image preprocessing
- Local storage reduces network usage

## Troubleshooting

### Common Issues

1. **Camera Permission Denied**
   - Go to Settings > Apps > Plant Disease Detector > Permissions
   - Enable Camera and Storage permissions

2. **Model Loading Failed**
   - Ensure `plant_disease.tflite` is in `assets/models/`
   - Check file size and integrity
   - Restart the app

3. **Poor Prediction Accuracy**
   - Use better lighting conditions
   - Focus on diseased areas
   - Avoid blurry or dark images
   - Ensure plant is clearly visible

4. **App Crashes**
   - Check device storage space
   - Restart the app
   - Clear app cache in device settings

### Performance Tips

- Close other apps to free memory
- Use natural lighting for photos
- Keep the app updated
- Regularly clear prediction history if storage is limited

## Development

### Adding New Diseases

1. **Update Model**: Retrain TensorFlow model with new disease classes
2. **Update Labels**: Modify `_getPlantDiseaseLabels()` in `ml_service.dart`
3. **Add Disease Data**: Include new disease information in `disease_data.dart`
4. **Test**: Verify predictions and database integration

### Customizing UI

- Modify theme in `main.dart`
- Update colors in `ThemeData`
- Customize icons and layouts in screen files

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Disease information based on scientific agricultural research
- TensorFlow Lite team for mobile ML framework
- Flutter team for cross-platform development framework
- Plant pathology experts for disease descriptions and management strategies

## Support

For technical support or questions:
- Check the troubleshooting section
- Review Flutter documentation
- Submit issues on the project repository

## Version History

- **v1.0.0**: Initial release with 35+ disease detection
  - Offline TensorFlow Lite integration
  - Comprehensive disease database
  - Camera and gallery support
  - Prediction history
  - Settings and preferences

