import 'package:flutter/material.dart';
import 'screens/torcidometro_screen.dart'; // Importa a tela principal.


//colocar ícone do perfil do time em cima da barrinha. 
void main() => runApp(const TorcidometroApp()); // Inicia o aplicativo.

class TorcidometroApp extends StatelessWidget {
  const TorcidometroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove o banner de debug.
      title: 'Torcidômetro', // Define o título do aplicativo.
      theme: ThemeData(primarySwatch: Colors.blue), // Define o tema.
      home: const TorcidometroScreen(), // Define a tela principal.
    );
  }
}
