import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trabalho01/model/user.dart';
import 'package:email_validator/email_validator.dart';
import 'package:trabalho01/utils/database_helpers.dart';
import 'dart:developer';

class TelaInfos extends StatefulWidget {
  const TelaInfos({super.key});

  @override
  State<TelaInfos> createState() => CompleteFormState();
}

String? _character;
List<Map<String, dynamic>> _journals = [];
bool _isLoading = true;
String user = FirebaseAuth.instance.currentUser.toString();

class CompleteFormState extends State<TelaInfos> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController idadeController = new TextEditingController();
  TextEditingController alturaController = new TextEditingController();
  TextEditingController pesoController = new TextEditingController();
  TextEditingController sexoController = new TextEditingController();
  //final User _newUser = User();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: pesoController,
            decoration: const InputDecoration(
              icon: const Icon(Icons.line_weight),
              hintText: 'Adicione o seu peso',
              labelText: 'Peso (KG)',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Adicione o seu peso';
              }
              return null;
            },
          ),
          TextFormField(
            controller: alturaController,
            decoration: const InputDecoration(
              icon: const Icon(Icons.height),
              hintText: 'Adicione a sua altura',
              labelText: 'Altura',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Adicione a sua altura';
              }
              return null;
            },
          ),
          TextFormField(
            controller: idadeController,
            decoration: const InputDecoration(
              icon: const Icon(Icons.calendar_today),
              hintText: 'Adicione a sua idade',
              labelText: 'Idade',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Adicione a sua idade';
              }
              return null;
            },
          ),
          Container(
              padding: EdgeInsets.only(left: 150.0, top: 40.0),
              child: ElevatedButton(
                child: Text('Feito'),
                onPressed: () {
                  // It returns true if the form is valid, otherwise returns false
                  if (_formKey.currentState!.validate()) {
                    int peso = int.parse(pesoController.text);
                    String treino = "";
                    if (peso == 70) {
                      treino = "Rosca direta 10x";
                    }

                    FirebaseFirestore.instance.collection('infos').add({
                      'peso': pesoController.text,
                      'altura': alturaController.text,
                      'idade': idadeController.text,
                      'email': FirebaseAuth.instance.currentUser!.email!,
                      'nome': FirebaseAuth.instance.currentUser!.displayName!,
                      'treino': treino
                    });
                    //   Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => MyApp2()));
                  }
                },
              )),
        ],
      ),
    );
  }

  /*List<Info> words = [];
  _read() async {
    log('Read Complete Data');
    DatabaseHelper helper = DatabaseHelper.instance;
    List<Info>? temp = await helper.queryAllWords();
    setState(() {
      words = temp ?? [];
    });
  }
  */
  /*

  _delete(int id) async {
    // delete one word
    DatabaseHelper helper = DatabaseHelper.instance;
    log('Delete Data from id: $id');
    await helper.deleteWord(id);
    _read();
  }
  */

  // Insert a new journal to the database
  Future<void> _addItem() async {
    await SQLHelper.createItem(idadeController.text, alturaController.text,
        pesoController.text, _character.toString().characters.toString());
    _refreshJournals();
  }

  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

// Delete an item
  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a journal!'),
    ));
    _refreshJournals();
  }
}
