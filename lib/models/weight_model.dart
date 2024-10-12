import 'package:json_annotation/json_annotation.dart';
import 'package:track_my_weight/core/constants/constants.dart';
import 'package:track_my_weight/models/enums.dart';

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
  String? weight;
  DateTime? recordDate;
  WeightUnit? unit;

  WeightModel({this.weight, this.recordDate, this.unit});

  factory WeightModel.fromJson(Json json) => _$WeightModelFromJson(json);

  Json toJson() => _$WeightModelToJson(this);
}
