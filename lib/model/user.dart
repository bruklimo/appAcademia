import 'package:flutter/material.dart';

class User {
  String? nome;
  String? senha;
  String? email;

  User({this.nome, this.senha, this.email});

  @override
  String toString() {
    // TODO: implement toString
    return "$nome";
  }
}
