// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_disease.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlantDisease _$PlantDiseaseFromJson(Map<String, dynamic> json) => PlantDisease(
      id: json['id'] as String,
      name: json['name'] as String,
      scientificName: json['scientificName'] as String,
      crop: json['crop'] as String,
      pathogenType: json['pathogenType'] as String,
      description: json['description'] as String,
      symptoms:
          (json['symptoms'] as List<dynamic>).map((e) => e as String).toList(),
      diseasecycle: json['diseasecycle'] as String,
      environmentalConditions: json['environmentalConditions'] as String,
      culturalManagement: (json['culturalManagement'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      chemicalManagement: (json['chemicalManagement'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      resistantVarieties: (json['resistantVarieties'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PlantDiseaseToJson(PlantDisease instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'scientificName': instance.scientificName,
      'crop': instance.crop,
      'pathogenType': instance.pathogenType,
      'description': instance.description,
      'symptoms': instance.symptoms,
      'diseasecycle': instance.diseasecycle,
      'environmentalConditions': instance.environmentalConditions,
      'culturalManagement': instance.culturalManagement,
      'chemicalManagement': instance.chemicalManagement,
      'resistantVarieties': instance.resistantVarieties,
    };

PredictionResult _$PredictionResultFromJson(Map<String, dynamic> json) =>
    PredictionResult(
      id: json['id'] as String,
      imagePath: json['imagePath'] as String,
      diseaseId: json['diseaseId'] as String,
      diseaseName: json['diseaseName'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      isFavorite: json['isFavorite'] as bool? ?? false,
    );

Map<String, dynamic> _$PredictionResultToJson(PredictionResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imagePath': instance.imagePath,
      'diseaseId': instance.diseaseId,
      'diseaseName': instance.diseaseName,
      'confidence': instance.confidence,
      'timestamp': instance.timestamp.toIso8601String(),
      'isFavorite': instance.isFavorite,
    };
