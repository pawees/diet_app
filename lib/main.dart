import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app_training/repository/service.dart';
import 'package:game_app_training/ui/home_page.dart';
import 'package:game_app_training/utils/app_bloc_oserver.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

// import 'package:flutter_dotenv/flutter_dotenv.dart';
class MyHttpOverrides extends HttpOverrides {
 @override
 HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
     ..badCertificateCallback =
         (X509Certificate cert, String host, int port) => true;
 }
}
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // await dotenv.load(fileName: "assets/.env");
  HttpOverrides.global = MyHttpOverrides();
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: BlocsObservers(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Info Games',
      theme: ThemeData(
        primarySwatch: Colors.green,
        bottomNavigationBarTheme:
         BottomNavigationBarThemeData(selectedItemColor: Colors.green,unselectedItemColor: Colors.grey)
      ),
      home: const HomePage(),
    );
  }
}
