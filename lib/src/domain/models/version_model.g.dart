// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersionModel _$VersionModelFromJson(Map<String, dynamic> json) => VersionModel(
      major: (json['major'] as num?)?.toInt() ?? 1,
      minor: (json['minor'] as num?)?.toInt() ?? 0,
      patch: (json['patch'] as num?)?.toInt() ?? 0,
      build: (json['build'] as num?)?.toInt() ?? 0,
      buildAt: (json['buildAt'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$VersionModelToJson(VersionModel instance) =>
    <String, dynamic>{
      'major': instance.major,
      'minor': instance.minor,
      'patch': instance.patch,
      'build': instance.build,
      'buildAt': instance.buildAt,
    };
