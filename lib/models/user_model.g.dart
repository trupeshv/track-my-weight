// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataModel _$UserDataModelFromJson(Map<String, dynamic> json) =>
    UserDataModel(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      weightUnit: $enumDecodeNullable(_$WeightUnitEnumMap, json['weightUnit']),
      scheduleTime: _$JsonConverterFromJson<String, TimeOfDay>(
          json['scheduleTime'], const TimeOfDayConverter().fromJson),
    );

Map<String, dynamic> _$UserDataModelToJson(UserDataModel instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'weightUnit': _$WeightUnitEnumMap[instance.weightUnit],
      'scheduleTime': _$JsonConverterToJson<String, TimeOfDay>(
          instance.scheduleTime, const TimeOfDayConverter().toJson),
    };

const _$WeightUnitEnumMap = {
  WeightUnit.KG: 'KG',
  WeightUnit.LB: 'LB',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
