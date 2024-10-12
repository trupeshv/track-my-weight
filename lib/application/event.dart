part of 'bloc.dart';

abstract class AppEvent {
  const AppEvent();
}

class SaveUserData extends AppEvent {
  final UserDataModel userData;

  const SaveUserData({required this.userData});
}

class InitNotification extends AppEvent{}

class SaveRecord extends AppEvent{
  final WeightModel weightData;

  const SaveRecord({required this.weightData});
}