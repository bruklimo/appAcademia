import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trabalho01/model/user.dart';
import 'package:email_validator/email_validator.dart';

class MontaDieta extends StatefulWidget {
  const MontaDieta({super.key});

  @override
  State<MontaDieta> createState() => CompleteFormState();
}

final db = FirebaseFirestore.instance;

final infos = db
    .collection("infos")
    .where("email", isEqualTo: FirebaseAuth.instance.currentUser!.email!);

class CompleteFormState extends State<MontaDieta> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Treino Personalizado"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('treinos').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                return Card(
                  child: ListTile(
                    title: Text(doc.data().toString()),
                  ),
                );
              }).toList(),
            );
        },
      ),
    );
  }
}


//  title: Text(doc.data()['title']),