import 'package:flutter/material.dart';
import 'package:track_my_weight/app.dart';
import 'package:timezone/data/latest_all.dart' as tz;

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  runApp(const App());
}
