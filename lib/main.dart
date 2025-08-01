import 'package:firebase_core/firebase_core.dart';
import 'package:firebasedemo/presentation/Components/Screens/Add_Task_Page.dart';
import 'package:firebasedemo/presentation/Components/Screens/LoginPage.dart';
import 'package:firebasedemo/presentation/Components/Screens/RegPage.dart';
import 'package:firebasedemo/presentation/Components/Screens/SplashView.dart';
import 'package:firebasedemo/presentation/Components/Screens/toDo_home_page.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: "/splash",
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => RegPage(),
        '/home': (context) => TodoHomePage(),
        '/addtask': (context) => AddTaskVeiw(),
        '/splash': (context) => Splashview(),
      },
      theme: ThemeData(
          textTheme: TextTheme(
            displayMedium: TextStyle(color: Colors.white, fontSize: 18),
            displaySmall: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          scaffoldBackgroundColor: Color(0xff0E1D3E),
          appBarTheme: AppBarTheme(
              backgroundColor: Color(0xff0E1D3E),
              iconTheme: IconThemeData(color: Colors.white)),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true),
    );
  }
}
