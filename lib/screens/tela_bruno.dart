import 'package:flutter/material.dart';

class BrunoScreen extends StatelessWidget {
  const BrunoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            /*
  Maneira clássica de adicionar uma
  borda. Vamos simplesmente circular
  as bordas do container.
  */
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              // Fazendo a borda circular.
              borderRadius: BorderRadius.circular(15),

              // Colocando borda em todos os lados.
              border: Border.all(
                color: Colors.black,
                width: 4.0,
              ),
            ),
            // Arredondando também a imagem.
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/rir.jpg',
                  width: 200,
                )),
          ),
          const Text("Bruno Klimowitsch",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                letterSpacing: 2, // Default is one
              )),
          const Text(
            "Estudante do sexto semestre de Análise e Desenvolvimento de Sistemas da Faculdade de Tecnologia da Unicamp.",
            style: TextStyle(
                fontSize: 10,
                color: Colors.blue,
                letterSpacing: 2,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
