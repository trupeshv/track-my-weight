part of 'bloc.dart';

abstract class AppEvent {
  const AppEvent();
}

class SaveUserData extends AppEvent {
  final UserDataModel userData;

  const SaveUserData({required this.userData});
}

