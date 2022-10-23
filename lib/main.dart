<<<<<<< HEAD
// @dart=2.17
import 'package:firebase_core/firebase_core.dart';
import 'package:trabalho01/screens/main2.dart';
import 'package:trabalho01/screens/tela_leo.dart';
import 'package:trabalho01/screens/tela_bruno.dart';
import 'package:trabalho01/screens/tela_infos.dart';
import 'package:flutter/material.dart';
import 'package:trabalho01/screens/tela_monta_dieta.dart';
import 'package:trabalho01/screens/tela_maps.dart';
=======
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
>>>>>>> 0fb0d003d33211b97a9412c9e7c536148ffb9cf5
import 'package:flutter/material.dart';
import 'package:trabalho01/utils/authentication.dart';

<<<<<<< HEAD
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

=======
import 'auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
>>>>>>> 0fb0d003d33211b97a9412c9e7c536148ffb9cf5
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
      home: Authentication().handleAuthState(),
=======
      home: AuthService().handleAuthState(),
>>>>>>> 0fb0d003d33211b97a9412c9e7c536148ffb9cf5
    );
  }
}
