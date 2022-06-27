import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app_training/ui/home_page.dart';
import 'package:game_app_training/utils/app_bloc_oserver.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  // await dotenv.load(fileName: "assets/.env");
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
      ),
      home: const HomePage(),
    );
  }
}
