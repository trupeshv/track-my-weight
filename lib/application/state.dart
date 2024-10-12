part of 'bloc.dart';

abstract class AppState {
  const AppState();
}

class Initial extends AppState {}

class Loading extends AppState {}

class SavedUserData extends AppState {}

class WeightLoading extends AppState {}

class SavedWeight extends AppState {
  final WeightModel saveWeight;

  const SavedWeight({required this.saveWeight});
}

class Error extends AppState {
  final String error;

  const Error({required this.error});
}
