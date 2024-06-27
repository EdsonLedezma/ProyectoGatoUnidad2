//celda.dart
import 'package:gato/config/config.dart';

class Celda extends StatelessWidget {
  final Estados? inicial;
  final double? espacio;
  final Function() clicked;
  const Celda({required this.inicial,required this.espacio,required this.clicked, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: espacio,
      height: espacio,
      child: CupertinoButton(
        child: seleccionImagen(),
        onPressed:clicked
      ),
    );
  }

  Widget seleccionImagen(){
    if(inicial == Estados.vacio) {
      return Container();
    } else
      if(inicial == Estados.x) {
        return Image.asset("resources/images/x.png");
      }
   else {
        return Image.asset("resources/images/o.png");
      }
  }
}
