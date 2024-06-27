import '../config/config.dart';

class Botones extends StatefulWidget {
  final Function(Estados) onGameEnd;

  const Botones({required this.onGameEnd, super.key});

  @override
  State<Botones> createState() => _BotonesState();
}

class _BotonesState extends State<Botones> {
  double ancho = 0, alto = 0;
  Estados inicial = Estados.x;
  int clicks = 0;

  @override
  Widget build(BuildContext context) {
    ancho = MediaQuery.of(context).size.width;
    alto = MediaQuery.of(context).size.height;
    return SizedBox(
      width: ancho,
      height: alto,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Row(
              children: [
                Celda(inicial: tablero[0], espacio: ancho / 3, clicked: () => clicked(0)),
                Celda(inicial: tablero[1], espacio: ancho / 3, clicked: () => clicked(1)),
                Celda(inicial: tablero[2], espacio: ancho / 3, clicked: () => clicked(2)),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Celda(inicial: tablero[3], espacio: ancho / 3, clicked: () => clicked(3)),
                Celda(inicial: tablero[4], espacio: ancho / 3, clicked: () => clicked(4)),
                Celda(inicial: tablero[5], espacio: ancho / 3, clicked: () => clicked(5)),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Celda(inicial: tablero[6], espacio: ancho / 3, clicked: () => clicked(6)),
                Celda(inicial: tablero[7], espacio: ancho / 3, clicked: () => clicked(7)),
                Celda(inicial: tablero[8], espacio: ancho / 3, clicked: () => clicked(8)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void clicked(int index) {
    if (tablero[index] == Estados.vacio) {
      tablero[index] = inicial;
      inicial = inicial == Estados.x ? Estados.o : Estados.x;

      setState(() {});
      if (++clicks >= 5) {
        Estados ganador = buscarGanador();
        if (ganador != Estados.vacio) {
          widget.onGameEnd(ganador);
          clicks = 0; // Reset clicks when there is a winner
        } else if (clicks == 9) {
          widget.onGameEnd(Estados.vacio);
          clicks = 0; // Reset clicks on draw
        }
      }
    }
  }

  Estados buscarGanador() {
    for (int i = 0; i < tablero.length; i += 3) {
      sonIguales(i, i + 1, i + 2);
    }
    for (int i = 0; i < 3; i++) {
      sonIguales(i, i + 3, i + 6);
    }
    sonIguales(0, 4, 8);
    sonIguales(2, 4, 6);
    if (ganador[Estados.x] == true) {
      return Estados.x;
    }
    if (ganador[Estados.o] == true) {
      return Estados.o;
    }

    return Estados.vacio;
  }

  void sonIguales(int a, int b, int c) {
    if (tablero[a] != Estados.vacio) {
      if (tablero[a] == tablero[b] && tablero[b] == tablero[c]) {
        ganador[tablero[a]] = true;
      }
    }
  }
}
