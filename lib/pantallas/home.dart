import 'package:flutter/material.dart';
import '../config/config.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int xWins = 0;
  int oWins = 0;
  int draws = 0;
  bool _isMenuOpen = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
      if (_isMenuOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _exitGame() {
    Future.delayed(const Duration(milliseconds: 500), () {
      SystemNavigator.pop();
    });
  }

  void _restartGame() {
    setState(() {
      tablero = List.filled(9, Estados.vacio);
      ganador = {Estados.o: false, Estados.x: false};
    });
  }

  void _newGame() {
    setState(() {
      tablero = List.filled(9, Estados.vacio);
      ganador = {Estados.o: false, Estados.x: false};
      xWins = 0;
      oWins = 0;
      draws = 0;
    });
  }

  void _showConfirmationDialog(String title, Function onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: const Text("¿Está seguro que desea continuar?"),
          actions: <Widget>[
            TextButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Sí"),
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
            ),
          ],
        );
      },
    );
  }

  void _showEndGameDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("Salir del juego"),
              onPressed: () {
                _exitGame();
              },
            ),
            TextButton(
              child: const Text("Continuar jugando"),
              onPressed: () {
                Navigator.of(context).pop();
                _restartGame();
              },
            ),
          ],
        );
      },
    );
  }

  void _updateScore(Estados winner) {
    setState(() {
      if (winner == Estados.x) {
        xWins++;
        _showEndGameDialog("¡Felicidades!", "X ha ganado. ¿Desea continuar jugando o salir del juego?");
      } else if (winner == Estados.o) {
        oWins++;
        _showEndGameDialog("¡Felicidades!", "O ha ganado. ¿Desea continuar jugando o salir del juego?");
      } else {
        draws++;
        _showEndGameDialog("Empate", "El juego ha terminado en empate. ¿Desea continuar jugando o salir del juego?");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: CustomAppBar(
        onExit: _exitGame,
        onRestart: _restartGame,
        onNewGame: _newGame,
        xWins: xWins,
        oWins: oWins,
        draws: draws,
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Image.asset("resources/images/boards.png"),
            Botones(onGameEnd: _updateScore),
            if (_isMenuOpen) _buildMenu(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleMenu,
        child: AnimatedIcon(
          icon: AnimatedIcons.home_menu,
          progress: _animationController,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildMenu() {
    return Stack(
      children: [
        Positioned(
          bottom: 80.0,
          left: MediaQuery.of(context).size.width / 2 - 56,
          child: Column(
            children: [
              FloatingActionButton(

                mini: true,
                onPressed: () {
                  _toggleMenu();
                  _showConfirmationDialog("¿Está seguro que desea reiniciar el juego?", _restartGame);
                },
                child: const Icon(Icons.refresh),
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                mini: true,
                onPressed: () {
                  _toggleMenu();
                  _showConfirmationDialog("¿Está seguro que desea salir del juego?", _exitGame);
                },
                child: const Icon(Icons.exit_to_app),
              ),
            ],
          ),
        ),
      ],
    );
  }
}