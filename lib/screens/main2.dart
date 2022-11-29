// @dart=2.17
import 'package:trabalho01/screens/tela_leo.dart';
import 'package:trabalho01/screens/tela_bruno.dart';
import 'package:trabalho01/screens/tela_infos.dart';
import 'package:flutter/material.dart';
import 'package:trabalho01/screens/tela_maps.dart';

void main() => runApp(const MyApp2());

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gym App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(tabs: [
              Tab(icon: Icon(Icons.sports_gymnastics)),
              Tab(icon: Icon(Icons.map_sharp)),
            ]),
            title: const Text("Gym App"),
          ),
          body: const TabBarView(
            children: [
              Treinos(),
              MostraMaps(),
            ],
          ),
        ),
      ),
    );
  }
}
