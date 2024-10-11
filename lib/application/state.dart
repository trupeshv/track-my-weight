part of 'bloc.dart';

abstract class AppState {
  const AppState();
}

class Initial extends AppState {}

class Loading extends AppState {}

class SavedUserData extends AppState {}

class Error extends AppState {
  final String error;

  const Error({required this.error});
}
