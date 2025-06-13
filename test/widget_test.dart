import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plant_disease_detector/main.dart';
import 'package:plant_disease_detector/services/ml_service.dart';
import 'package:plant_disease_detector/services/database_service.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Create mock services for testing
    final mlService = MLService();
    final databaseService = DatabaseService();
    
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(
      mlService: mlService,
      databaseService: databaseService,
    ));

    // Verify that the app starts with the home screen
    expect(find.text('Plant Disease Detector'), findsOneWidget);
  });
}

