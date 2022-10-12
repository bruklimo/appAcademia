import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trabalho01/model/user.dart';
import 'package:email_validator/email_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => CompleteFormState();
}

String? _character;

class CompleteFormState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //final User _newUser = User();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text("Gostaríamos de saber algumas informações sobre você:\n",
                style: TextStyle(fontSize: 20, fontFamily: 'Arial')),
            TextField(
              decoration: InputDecoration(
                labelText: "Idade", //babel text
                border: OutlineInputBorder(),
                hintText: 'Digite sua idade',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Altura", //babel text
                border: OutlineInputBorder(),
                hintText: 'Digite sua altura',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Peso", //babel text
                hintText: 'Digite seu peso',
              ),
            ),
            const Text(
              'Selecione seu sexo:\n',
              style: TextStyle(fontSize: 20, fontFamily: 'Arial'),
            ),
            ListTile(
              title: const Text('Masculino'),
              leading: Radio<String>(
                value: "Masculino",
                groupValue: _character,
                onChanged: (value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Feminino'),
              leading: Radio<String>(
                value: "Feminino",
                groupValue: _character,
                onChanged: (value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(children: [
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.blue,
                          duration: const Duration(seconds: 10),
                          content: Text(
                              "Bem vindo!\nSeu sexo é  ${_character.toString().characters}"),
                          action: SnackBarAction(
                              label: "HomePage",
                              onPressed: () {
                                //vai pra tela inicial
                              }),
                        ),
                      );
                    }
                  },
                  child: const Text('Monta treino'),
                ),
                //    ElevatedButton(
                //    onPressed: () {
                //       //vai pra pagina de cadastro
                //    },
                //   child: const Text('Cadastrar'),
                //   ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
