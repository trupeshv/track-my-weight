import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:track_my_weight/core/constants/constants.dart';
import 'enums.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserDataModel {
  String? firstName;
  String? lastName;
  WeightUnit? weightUnit;
  @TimeOfDayConverter()
  TimeOfDay? scheduleTime;

  UserDataModel({this.firstName, this.lastName, this.weightUnit, this.scheduleTime});

  factory UserDataModel.fromJson(Json json) => _$UserDataModelFromJson(json);

  Json toJson() => _$UserDataModelToJson(this);
}


class TimeOfDayConverter implements JsonConverter<TimeOfDay, String> {
  const TimeOfDayConverter();

  @override
  TimeOfDay fromJson(String json) {
    final parts = json.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  @override
  String toJson(TimeOfDay object) {
    return '${object.hour.toString().padLeft(2, '0')}:${object.minute.toString().padLeft(2, '0')}';
  }
}