import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class PeliculaShowPage extends StatelessWidget {
  const PeliculaShowPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _crearAppBar(pelicula),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0),
                _crearTituloPoster(context, pelicula),
                _descripcion(pelicula),
                _crearCasting(pelicula.id),
              ],
            ),
          )
        ],
      ),
    );
  }

  _crearAppBar(pelicula) => SliverAppBar(
        elevation: 2.0,
        backgroundColor: Colors.white,
        expandedHeight: 200.0,
        floating: false,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(pelicula.title),
          background: FadeInImage(
            placeholder: AssetImage('assets/No_image_available_600_x_450.png'),
            image: pelicula.getBackgroundImage(),
            fit: BoxFit.cover,
          ),
        ),
      );

  _crearTituloPoster(context, Pelicula pelicula) => Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Hero(
              tag: pelicula.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image(
                  image: pelicula.getPosterImage(),
                  height: 150,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pelicula.title,
                    style: Theme.of(context).textTheme.headline5,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    pelicula.originalTitle,
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Icon(Icons.star),
                      Text(pelicula.voteAverage.toString()),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );

  _descripcion(Pelicula pelicula) => Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        child: Text(pelicula.overview),
      );

  _crearCasting(int peliculaId) {
    final PeliculasProvider peliculaProvider = PeliculasProvider();

    return FutureBuilder(
      future: peliculaProvider.getCast(peliculaId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _crearActoresPageView(snapshot.data);
        }

        return Container();
      },
    );
  }

  _crearActoresPageView(List<Actor> actores) => Container(
        padding: EdgeInsets.only(left: 20),
        child: SizedBox(
          height: 200,
          child: ListView.builder(
            controller: PageController(
              initialPage: 1,
              viewportFraction: 0.3,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: actores.length,
            itemBuilder: (context, i) {
              return _actorTarjeta(actores[i]);
            },
          ),
        ),
      );

  _actorTarjeta(Actor actor) => Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: FadeInImage(
                placeholder: AssetImage('assets/no_avatar.png'),
                image: actor.getPosterImage(),
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              actor.name,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
}
