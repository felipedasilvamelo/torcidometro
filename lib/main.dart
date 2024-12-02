import 'package:flutter/material.dart';
import 'screens/torcidometro_screen.dart'; 



void main() => runApp(const TorcidometroApp()); 

class TorcidometroApp extends StatelessWidget {
  const TorcidometroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'Torcidômetro', 
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TorcidometroScreen(), 
    );
  }
}
