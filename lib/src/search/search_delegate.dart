import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  Pelicula? seleccion;
  final peliculasProvider = PeliculasProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones del AppBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crear los resultados a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return Container();

    return FutureBuilder(
      future: peliculasProvider.search(query),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        print(snapshot.data);
        return ListView(
          children: snapshot.data
              ?.map<Widget>((pelicula) => ListTile(
                    leading: Hero(
                      tag: pelicula.getIdTarjeta(),
                      child: FadeInImage(
                        image: pelicula.getPosterImage(),
                        placeholder: AssetImage(
                            'assets/No_image_available_600_x_450.png'),
                        fit: BoxFit.contain,
                        width: 50,
                      ),
                    ),
                    title: Text(pelicula.title),
                    subtitle: Text(pelicula.originalTitle),
                    onTap: () {
                      close(context, null);
                      Navigator.pushNamed(context, 'show', arguments: pelicula);
                    },
                  ))
              .toList(),
        );
      },
    );
  }
}
