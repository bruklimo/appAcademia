// main.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:trabalho01/utils/database_helpers.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../utils/authentication.dart';

void main() {
  runApp(const Treinos());
}

class Treinos extends StatelessWidget {
  const Treinos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
        // Remove the debug banner
        debugShowCheckedModeBanner: false,
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String user = FirebaseAuth.instance.currentUser!.email.toString();
  // All journals
  List<Map<String, dynamic>> _journals = [];

  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await SQLHelper.getItem(user);
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.blue,
            duration: const Duration(seconds: 10),
            content: Text(
                'Para criar um treino, clique no botão ao lado e insira seus dados'))));

    _refreshJournals(); // Loading the diary when the app starts
  }

  final TextEditingController _idadeController = new TextEditingController();
  final TextEditingController _alturaController = new TextEditingController();
  final TextEditingController _pesoController = new TextEditingController();
  String? tipoTreino;
  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void _showForm(int? id) async {
    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingJournal =
          _journals.firstWhere((element) => element['id'] == id);
      _idadeController.text = existingJournal['idade'];
      _alturaController.text = existingJournal['altura'];
      _pesoController.text = existingJournal['peso'];
    }

    // Initial Selected Value
    String dropdownvalue = 'perna';
    tipoTreino = 'perna';

    // List of items in our dropdown menu
    var items = [
      'perna',
      'braço',
    ];

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              height: 350,
              width: 200,
              padding: const EdgeInsets.only(bottom: 5),
              child: Expanded(
                flex: 4,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      controller: _idadeController,
                      decoration:
                          const InputDecoration(hintText: 'Idade (anos)'),
                    ),
                    const SizedBox(
                      height: 10,
                      width: 20,
                    ),
                    TextField(
                      controller: _alturaController,
                      decoration: const InputDecoration(hintText: 'Altura (m)'),
                    ),
                    const SizedBox(
                      height: 10,
                      width: 20,
                    ),
                    TextField(
                      controller: _pesoController,
                      decoration: const InputDecoration(hintText: 'Peso (kg)'),
                    ),
                    const SizedBox(
                      height: 10,
                      width: 20,
                    ),
                    const SizedBox(
                      height: 10,
                      width: 20,
                    ),
                    const Text("Tipo  de treino"),
                    DropdownButton(
                      // Initial Value
                      value: dropdownvalue,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) async {
                        setState(() async {
                          dropdownvalue = newValue!;
                          tipoTreino = newValue;
                        });
                      },
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // Save new journal
                        if (id == null) {
                          await _addItem();
                        }

                        if (id != null) {
                          await _updateItem(id);
                        }

                        // Clear the text fields
                        _idadeController.text = '';
                        _alturaController.text = '';
                        _pesoController.text = '';

                        // Close the bottom sheet
                        Navigator.of(context).pop();
                      },
                      child: const Text('Criar Novo Treino'),
                    )
                  ],
                ),
              ),
            ));
  }

// Insert a new journal to the database
  Future<void> _addItem() async {
    double peso = double.parse(_pesoController.text);
    double altura = double.parse(_alturaController.text);
    String treino = "";
    String obs = "";
//IMC = Peso ÷ (Altura × Altura)

    double imc = peso / (altura * 2);

    print(imc);

    // novos

    if (imc >= 18.5 && imc <= 24.9) {
      if (tipoTreino == "perna") {
        treino = "Leg press";
        obs = "Repetições: 3x10, Peso ideal: 30kg";
      } else if (tipoTreino == "braço") {
        treino = "Rosca direta";
        obs = "Repetições: 3x10, Peso ideal: 20kg";
      }
    } else if (imc >= 25.0 && imc <= 29.9) {
      if (tipoTreino == "perna") {
        treino = "Cadeira extensora";
        obs = "Repetições: 3x10, Peso ideal: 50kg";
      } else if (tipoTreino == "braço") {
        treino = "Supino inclinado";
        obs = "Repetições: 3x10, Peso ideal: 40kg";
      }
    } else if (imc >= 30.0 && imc <= 34.9) {
      if (tipoTreino == "perna") {
        treino = "Cadeira flexora";
        obs = "Repetições: 3x10, Peso ideal: 45kg";
      } else if (tipoTreino == "braço") {
        treino = "Elevação lateral";
        obs = "Repetições: 3x10, Peso ideal: 10kg";
      }
    } else if (imc >= 35.0 && imc <= 39.9) {
      if (tipoTreino == "perna") {
        treino = "Stiff";
        obs = "Repetições: 3x10, Peso ideal: 15kg";
      } else if (tipoTreino == "braço") {
        treino = "Coice Triceps";
        obs = "Repetições: 3x10, Peso ideal: 25kg";
      }
    } else if (imc >= 40.0) {
      if (tipoTreino == "perna") {
        treino = "Panturrilha sentada";
        obs = "Repetições: 3x10, Peso ideal: 30kg";
      } else if (tipoTreino == "braço") {
        treino = "Elevação fronta";
        obs = "Repetições: 3x10, Peso ideal: 15kg";
      }
    }

    // velhos

    //idosos

    await SQLHelper.createItem(_idadeController.text, _alturaController.text,
        _pesoController.text, user, treino, obs);
    _refreshJournals();
  }

  // Update an existing journal
  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(id, _idadeController.text,
        _alturaController.text, _pesoController.text);
    _refreshJournals();
  }

  // Delete an item
  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.blue,
      duration: const Duration(seconds: 10),
      content: Text('Treino deletado com sucesso!'),
    ));
    _refreshJournals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Treinos'),
        toolbarHeight: 20,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _journals.length,
              itemBuilder: (context, index) => Card(
                color: Colors.blue[200],
                margin: const EdgeInsets.all(15),
                child: ListTile(
                    title: Text(_journals[index]['treino']),
                    subtitle: Text(_journals[index]['obs']),
                    leading: Icon(Icons.sports_gymnastics_sharp),
                    trailing: SizedBox(
                      width: 50,
                      height: 100,
                      child: Row(
                        children: [
                          //   IconButton(
                          //    icon: const Icon(Icons.edit),
                          //   onPressed: () => _showForm(_journals[index]['id']),
                          // ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () =>
                                _deleteItem(_journals[index]['id']),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
      // floatingActionButton: FloatingActionButton(
      // child: const Icon(Icons.add),
      //  onPressed: () => _showForm(null),
      //  ),
      floatingActionButton: SpeedDial(
        //Speed dial menu
        // childMargin: 10, //margin bottom
        icon: Icons.menu, //icon on Floating action button
        activeIcon: Icons.close, //icon when menu is expanded on button
        backgroundColor: Colors.blue, //background color of button
        foregroundColor: Colors.white, //font color, icon color in button
        activeBackgroundColor:
            Colors.blue, //background color when menu is expanded
        activeForegroundColor: Colors.white,
        // buttonSize: 10, //button size
        visible: true,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.blue,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'), // action when menu opens
        onClose: () => print('DIAL CLOSED'), //action when menu closes

        elevation: 8.0, //shadow elevation of button
        shape: CircleBorder(), //shape of button

        children: [
          SpeedDialChild(
            //speed dial child
            child: Icon(Icons.logout),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            label: 'Log out',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => Authentication().signOut(),
          ),
          SpeedDialChild(
            child: Icon(Icons.add),
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            label: 'Adicionar um novo treino',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => _showForm(null),
          ),

          //add more menu item childs here
        ],
      ),
    );
  }
}
