import 'dart:async';
import 'dart:io';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:track_my_weight/core/persistence/preference_helper.dart';
import 'package:track_my_weight/core/utils/notification_utils.dart';
import 'package:track_my_weight/models/user_model.dart';
import 'package:track_my_weight/models/weight_model.dart';

part 'event.dart';

part 'state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(Initial()) {
    on<SaveUserData>(_saveUserData, transformer: droppable());
    on<InitNotification>(_initNotification, transformer: droppable());
    on<SaveRecord>(_saveRecord, transformer: droppable());
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
    await NotificationUtils()
        .scheduleNotification(scheduledNotificationDateTime: scheduledNotificationDateTime);
  }

  Future<void> _initNotification(InitNotification event, Emitter<AppState> emit) async {
    try {
      if (Platform.isAndroid) {
        final AndroidFlutterLocalNotificationsPlugin? androidImplementation = NotificationUtils()
            .notificationsPlugin
            .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

        await androidImplementation?.requestNotificationsPermission();
      }
      if (Platform.isIOS) {
        await NotificationUtils()
            .notificationsPlugin
            .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            );
      }
    } catch (e) {
      emit(Error(error: e.toString()));
    }
  }

  Future<void> _saveRecord(SaveRecord event, Emitter<AppState> emit) async {
    try {
      emit(WeightLoading());
      await PreferenceHelper.setRecordList(weightData: event.weightData);
      emit(SavedWeight(saveWeight: event.weightData));
    } catch (e) {
      emit(Error(error: e.toString()));
    }
  }
}
