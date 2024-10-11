import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_my_weight/core/persistence/preference_helper.dart';
import 'package:track_my_weight/core/utils/notification_utils.dart';
import 'package:track_my_weight/models/user_model.dart';

part 'event.dart';

part 'state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(Initial()) {
    on<SaveUserData>(_saveUserData, transformer: droppable());
  }

  Future<void> _saveUserData(SaveUserData event, Emitter<AppState> emit) async {
    try {
      emit(Loading());
      DateTime now = DateTime.now();
      await setNotification(
          scheduledNotificationDateTime: DateTime(now.year, now.minute, now.day,
              event.userData.scheduleTime!.hour, event.userData.scheduleTime!.minute));
      await PreferenceHelper.setUserData(event.userData);
      emit(SavedUserData());
    } catch (e) {
      emit(Error(error: e.toString()));
    }
  }

  Future<void> setNotification({required DateTime scheduledNotificationDateTime}) async {
    await NotificationUtils().cancelNotification();
    await NotificationUtils()
        .scheduleNotification(scheduledNotificationDateTime: scheduledNotificationDateTime);
  }
}
