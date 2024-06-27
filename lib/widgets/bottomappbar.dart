import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function onExit;
  final Function onRestart;
  final Function onNewGame;
  final int xWins;
  final int oWins;
  final int draws;

  const CustomAppBar({
    required this.onExit,
    required this.onRestart,
    required this.onNewGame,
    required this.xWins,
    required this.oWins,
    required this.draws,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Win X: $xWins', style: const TextStyle(color: Colors.green)),
          Text('Win O: $oWins', style: const TextStyle(color: Colors.pink)),
          Text('Empates: $draws', style: const TextStyle(color: Colors.black)),
        ],
      ),
      actions: [
        PopupMenuButton<String>(
          onSelected: (String result) {
            if (result == 'Salir del juego') {
              onExit();
            } else if (result == 'Reiniciar el juego') {
              onRestart();
            } else if (result == 'Juego nuevo') {
              onNewGame();
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'Salir del juego',
              child: Text('Salir del juego'),
            ),
            const PopupMenuItem<String>(
              value: 'Reiniciar el juego',
              child: Text('Reiniciar el juego'),
            ),
            const PopupMenuItem<String>(
              value: 'Juego nuevo',
              child: Text('Juego nuevo'),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
