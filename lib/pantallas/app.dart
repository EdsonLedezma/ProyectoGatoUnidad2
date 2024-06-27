
import 'package:flutter/material.dart';
import '../config/config.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
     theme: ThemeData(
       useMaterial3: true,
       primarySwatch: Colors.brown,
       primaryColor: Colors.deepPurple
     ),
      home: const Home(),
    );
  }
}
