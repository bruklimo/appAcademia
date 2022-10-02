import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../util/constants.dart';

class LeoScreen extends StatelessWidget {
  const LeoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
          gradient:
              const LinearGradient(colors: [Colors.indigo, Colors.blueAccent]),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
              offset: Offset(2.0, 2.0),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(20),
              child: Positioned(
                left: 15,
                child: FadeInDown(
                  delay: const Duration(milliseconds: 1),
                  child: Spin(
                    delay: const Duration(milliseconds: 1000),
                    child: SizedBox(
                      width: w / 2.8,
                      height: h / 5.5,
                      child: Center(
                        child: Image.asset(
                          'assets/images/pp.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Text(
              "Leonardo Rogelio",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 2, // Default is one
              ),
            ),
            const Text(
              "Sou um mero camponês aventureiro, vim de Canjordão,\n curto correr de bike no mato e tomar uns vinhos italianos!\n",
              style: TextStyle(
                  fontSize: 10,
                  color: Colors.orange,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
