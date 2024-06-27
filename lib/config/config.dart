//config.dart
library config.globals;
export 'package:flutter/cupertino.dart';
export 'package:gato/widgets/celda.dart';
export 'package:gato/pantallas/botones.dart';
export 'package:gato/pantallas/app.dart';
export 'package:gato/pantallas/home.dart';
export 'package:gato/widgets/bottomappbar.dart';
export 'package:flutter/services.dart';
enum Estados {vacio,x,o}
List<Estados> tablero = List.filled(9, Estados.vacio);
Map<Estados, bool> ganador = {Estados.o: false, Estados.x:false};