import 'package:json_annotation/json_annotation.dart';
import 'package:track_my_weight/core/constants/constants.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  final int id;
  final String title;
  final String body;

  NotificationModel(
      {required this.id, required this.title, required this.body});

  factory NotificationModel.fromJson(Json json) => _$NotificationModelFromJson(json);

  Json toJson() => _$NotificationModelToJson(this);
}
