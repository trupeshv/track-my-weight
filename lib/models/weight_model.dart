import 'package:json_annotation/json_annotation.dart';
import 'package:track_my_weight/core/constants/constants.dart';
import 'enums.dart';

part 'weight_model.g.dart';

@JsonSerializable()
class RecordModel {
  List<WeightModel>? recordList;

  RecordModel({this.recordList});

  factory RecordModel.fromJson(Json json) => _$RecordModelFromJson(json);

  Json toJson() => _$RecordModelToJson(this);
}

@JsonSerializable()
class WeightModel {
  double? weight;
  DateTime? recordDate;

  WeightModel({this.weight, this.recordDate});

  factory WeightModel.fromJson(Json json) => _$WeightModelFromJson(json);

  Json toJson() => _$WeightModelToJson(this);
}
