import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:plant_disease_detector/models/plant_disease.dart';
import 'package:plant_disease_detector/data/disease_data.dart';

class DatabaseService {
  Database? _database;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<void> initialize() async {
    try {
      final databasePath = await getDatabasesPath();
      final path = join(databasePath, 'plant_disease_detector.db');

      _database = await openDatabase(
        path,
        version: 1,
        onCreate: _createDatabase,
      );

      await _populateInitialData();
      _isInitialized = true;
      print('Database Service initialized successfully');
    } catch (e) {
      print('Error initializing Database Service: $e');
      _isInitialized = false;
    }
  }

  Future<void> _createDatabase(Database db, int version) async {
    // Create diseases table
    await db.execute('''
      CREATE TABLE diseases (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        scientific_name TEXT NOT NULL,
        crop TEXT NOT NULL,
        pathogen_type TEXT NOT NULL,
        description TEXT NOT NULL,
        symptoms TEXT NOT NULL,
        disease_cycle TEXT NOT NULL,
        environmental_conditions TEXT NOT NULL,
        cultural_management TEXT NOT NULL,
        chemical_management TEXT NOT NULL,
        resistant_varieties TEXT NOT NULL
      )
    ''');

    // Create predictions table
    await db.execute('''
      CREATE TABLE predictions (
        id TEXT PRIMARY KEY,
        image_path TEXT NOT NULL,
        disease_id TEXT NOT NULL,
        disease_name TEXT NOT NULL,
        confidence REAL NOT NULL,
        timestamp INTEGER NOT NULL,
        is_favorite INTEGER DEFAULT 0,
        FOREIGN KEY (disease_id) REFERENCES diseases (id)
      )
    ''');

    // Create settings table
    await db.execute('''
      CREATE TABLE settings (
        key TEXT PRIMARY KEY,
        value TEXT NOT NULL
      )
    ''');
  }

  Future<void> _populateInitialData() async {
    if (_database == null) return;

    // Check if diseases are already populated
    final count = Sqflite.firstIntValue(
      await _database!.rawQuery('SELECT COUNT(*) FROM diseases'),
    );

    if (count == 0) {
      await _insertInitialDiseases();
    }
  }

  Future<void> _insertInitialDiseases() async {
    // Use the comprehensive disease data from the parser
    final diseases = DiseaseDataParser.getInitialDiseaseData();
    
    for (final disease in diseases) {
      await _database!.insert('diseases', {
        'id': disease.id,
        'name': disease.name,
        'scientific_name': disease.scientificName,
        'crop': disease.crop,
        'pathogen_type': disease.pathogenType,
        'description': disease.description,
        'symptoms': jsonEncode(disease.symptoms),
        'disease_cycle': disease.diseasecycle,
        'environmental_conditions': disease.environmentalConditions,
        'cultural_management': jsonEncode(disease.culturalManagement),
        'chemical_management': jsonEncode(disease.chemicalManagement),
        'resistant_varieties': jsonEncode(disease.resistantVarieties),
      });
    }
  }

  Future<PlantDisease?> getDiseaseById(String id) async {
    if (_database == null) return null;

    final maps = await _database!.query(
      'diseases',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;

    final map = maps.first;
    return PlantDisease(
      id: map['id'] as String,
      name: map['name'] as String,
      scientificName: map['scientific_name'] as String,
      crop: map['crop'] as String,
      pathogenType: map['pathogen_type'] as String,
      description: map['description'] as String,
      symptoms: List<String>.from(jsonDecode(map['symptoms'] as String)),
      diseasecycle: map['disease_cycle'] as String,
      environmentalConditions: map['environmental_conditions'] as String,
      culturalManagement: List<String>.from(jsonDecode(map['cultural_management'] as String)),
      chemicalManagement: List<String>.from(jsonDecode(map['chemical_management'] as String)),
      resistantVarieties: List<String>.from(jsonDecode(map['resistant_varieties'] as String)),
    );
  }

  Future<List<PlantDisease>> getAllDiseases() async {
    if (_database == null) return [];

    final maps = await _database!.query('diseases');
    return maps.map((map) => PlantDisease(
      id: map['id'] as String,
      name: map['name'] as String,
      scientificName: map['scientific_name'] as String,
      crop: map['crop'] as String,
      pathogenType: map['pathogen_type'] as String,
      description: map['description'] as String,
      symptoms: List<String>.from(jsonDecode(map['symptoms'] as String)),
      diseasecycle: map['disease_cycle'] as String,
      environmentalConditions: map['environmental_conditions'] as String,
      culturalManagement: List<String>.from(jsonDecode(map['cultural_management'] as String)),
      chemicalManagement: List<String>.from(jsonDecode(map['chemical_management'] as String)),
      resistantVarieties: List<String>.from(jsonDecode(map['resistant_varieties'] as String)),
    )).toList();
  }

  Future<void> savePrediction(PredictionResult prediction) async {
    if (_database == null) return;

    await _database!.insert('predictions', {
      'id': prediction.id,
      'image_path': prediction.imagePath,
      'disease_id': prediction.diseaseId,
      'disease_name': prediction.diseaseName,
      'confidence': prediction.confidence,
      'timestamp': prediction.timestamp.millisecondsSinceEpoch,
      'is_favorite': prediction.isFavorite ? 1 : 0,
    });
  }

  Future<List<PredictionResult>> getPredictionHistory() async {
    if (_database == null) return [];

    final maps = await _database!.query(
      'predictions',
      orderBy: 'timestamp DESC',
    );

    return maps.map((map) => PredictionResult(
      id: map['id'] as String,
      imagePath: map['image_path'] as String,
      diseaseId: map['disease_id'] as String,
      diseaseName: map['disease_name'] as String,
      confidence: map['confidence'] as double,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
      isFavorite: (map['is_favorite'] as int) == 1,
    )).toList();
  }

  Future<void> updatePredictionFavorite(String id, bool isFavorite) async {
    if (_database == null) return;

    await _database!.update(
      'predictions',
      {'is_favorite': isFavorite ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deletePrediction(String id) async {
    if (_database == null) return;

    await _database!.delete(
      'predictions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  void dispose() {
    _database?.close();
    _isInitialized = false;
  }
}

