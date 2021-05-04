import 'package:flutter/material.dart';
import 'package:peliculas/src/pages/home_page.dart';
import 'package:peliculas/src/pages/pelicula_show.dart';

final routes = <String, WidgetBuilder>{
  '/': (context) => HomePage(),
  'show': (context) => PeliculaShowPage(),
};
