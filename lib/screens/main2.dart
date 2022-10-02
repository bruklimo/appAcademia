// @dart=2.17
import 'package:trabalho01/screens/tela_leo.dart';
import 'package:trabalho01/screens/tela_bruno.dart';
import 'package:trabalho01/screens/tela_login.dart';
import 'package:flutter/material.dart';
import 'package:trabalho01/screens/tela_monta_dieta.dart';
import 'package:trabalho01/screens/tela_monta_treino.dart';

void main() => runApp(const MyApp2());

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Academia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(tabs: [
              Tab(icon: Icon(Icons.sports_gymnastics_outlined)),
              Tab(icon: Icon(Icons.sports_gymnastics_rounded)),
              Tab(icon: Icon(Icons.sports_gymnastics_sharp)),
            ]),
            title: const Text("App Academia"),
          ),
          body: const TabBarView(
            children: [
              LoginScreen(),
              MontaDieta(),
              MontaTreino(),
            ],
          ),
        ),
      ),
    );
  }
}
