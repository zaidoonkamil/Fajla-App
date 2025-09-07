import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'bloc_observer.dart';
import 'core/network/local/cache_helper.dart';
import 'core/network/remote/dio_helper.dart';
import 'core/styles/themes.dart';
import 'features/splash/splash.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  DioHelper.init();
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.Debug.setAlertLevel(OSLogLevel.none);
  OneSignal.initialize("361394ea-ea14-4acf-9bd5-c723b4f93627");
  OneSignal.Notifications.requestPermission(true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeService().lightTheme,
      home: SplashScreen(),
    );
  }
}
