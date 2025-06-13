import 'package:json_annotation/json_annotation.dart';

part 'plant_disease.g.dart';

@JsonSerializable()
class PlantDisease {
  final String id;
  final String name;
  final String scientificName;
  final String crop;
  final String pathogenType;
  final String description;
  final List<String> symptoms;
  final String diseasecycle;
  final String environmentalConditions;
  final List<String> culturalManagement;
  final List<String> chemicalManagement;
  final List<String> resistantVarieties;

  const PlantDisease({
    required this.id,
    required this.name,
    required this.scientificName,
    required this.crop,
    required this.pathogenType,
    required this.description,
    required this.symptoms,
    required this.diseasecycle,
    required this.environmentalConditions,
    required this.culturalManagement,
    required this.chemicalManagement,
    required this.resistantVarieties,
  });

  factory PlantDisease.fromJson(Map<String, dynamic> json) =>
      _$PlantDiseaseFromJson(json);

  Map<String, dynamic> toJson() => _$PlantDiseaseToJson(this);
}

@JsonSerializable()
class PredictionResult {
  final String id;
  final String imagePath;
  final String diseaseId;
  final String diseaseName;
  final double confidence;
  final DateTime timestamp;
  final bool isFavorite;

  const PredictionResult({
    required this.id,
    required this.imagePath,
    required this.diseaseId,
    required this.diseaseName,
    required this.confidence,
    required this.timestamp,
    this.isFavorite = false,
  });

  factory PredictionResult.fromJson(Map<String, dynamic> json) =>
      _$PredictionResultFromJson(json);

  Map<String, dynamic> toJson() => _$PredictionResultToJson(this);

  PredictionResult copyWith({
    String? id,
    String? imagePath,
    String? diseaseId,
    String? diseaseName,
    double? confidence,
    DateTime? timestamp,
    bool? isFavorite,
  }) {
    return PredictionResult(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      diseaseId: diseaseId ?? this.diseaseId,
      diseaseName: diseaseName ?? this.diseaseName,
      confidence: confidence ?? this.confidence,
      timestamp: timestamp ?? this.timestamp,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

