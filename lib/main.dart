import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:test_project/provider/HomePageProvider.dart';
import 'package:test_project/provider/ProfileProvider.dart';
import 'package:test_project/provider/RecordAudioProvider.dart';
import 'package:test_project/screens/GoogleSignIn.dart';
import 'package:test_project/screens/Splash.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.openBox("api_resp");
  Hive.openBox("user");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> HomePageProvider()),
        ChangeNotifierProvider(create: (_)=> ProfileProvider()),
        ChangeNotifierProvider(create: (_)=> RecordAudioProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ),
        home: Splash(),
      ),
    );
  }
}
