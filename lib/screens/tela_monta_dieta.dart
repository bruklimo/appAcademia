import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trabalho01/screens/main2.dart';

void main() => runApp(MontaDieta());

class MontaDieta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'App Academia';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

TextEditingController idadeController = new TextEditingController();
TextEditingController alturaController = new TextEditingController();
TextEditingController pesoController = new TextEditingController();

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class, which holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  String user = FirebaseAuth.instance.currentUser!.displayName!;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) =>
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.blue,
            duration: const Duration(seconds: 10),
            content: Text(
                'Olá $user,  vamos precisar de algumas informações sobre você!'))));
  }

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
                    Query<Map<String, dynamic>> a = FirebaseFirestore.instance
                        .collection('infos')
                        .where("email");

                    Text(a.toString());
                  }
                },
              )),
        ],
      ),
    );
  }
}
