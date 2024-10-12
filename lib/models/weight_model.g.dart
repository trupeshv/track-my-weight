// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordModel _$RecordModelFromJson(Map<String, dynamic> json) => RecordModel(
      recordList: (json['recordList'] as List<dynamic>?)
          ?.map((e) => WeightModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecordModelToJson(RecordModel instance) =>
    <String, dynamic>{
      'recordList': instance.recordList,
    };

WeightModel _$WeightModelFromJson(Map<String, dynamic> json) => WeightModel(
      weight: json['weight'] as String?,
      recordDate: json['recordDate'] == null
          ? null
          : DateTime.parse(json['recordDate'] as String),
      unit: $enumDecodeNullable(_$WeightUnitEnumMap, json['unit']),
    );

Map<String, dynamic> _$WeightModelToJson(WeightModel instance) =>
    <String, dynamic>{
      'weight': instance.weight,
      'recordDate': instance.recordDate?.toIso8601String(),
      'unit': _$WeightUnitEnumMap[instance.unit],
    };

const _$WeightUnitEnumMap = {
  WeightUnit.KG: 'KG',
  WeightUnit.LB: 'LB',
};
