import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontalWidget extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguientePagina;

  const MovieHorizontalWidget({
    @required this.peliculas,
    Key key,
    @required this.siguientePagina,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final height = screenSize.height * 0.3;

    final _pageController = PageController(
      initialPage: 1,
      viewportFraction: 0.3,
    );

    _pageController.addListener(() {
      final pos = _pageController.position;
      if (pos.pixels < pos.maxScrollExtent - 200) return;

      siguientePagina();
    });

    return Container(
      height: height,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: (context, i) =>
            _crearTarjeta(context, peliculas[i], height),
      ),
    );
  }

  Widget _crearTarjeta(context, Pelicula pelicula, height) {
    pelicula.uniqueId = '${pelicula.id}-mh';
    final _tarjeta = Container(
      margin: EdgeInsets.only(right: 15),
      child: Column(
        children: [
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: FadeInImage(
                placeholder:
                    AssetImage('assets/No_image_available_600_x_450.png'),
                image: pelicula.getPosterImage(),
                fit: BoxFit.cover,
                height: height - 50,
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );

    return GestureDetector(
      child: _tarjeta,
      onTap: () => _cargarPelicula(context, pelicula),
    );
  }

  void _cargarPelicula(context, Pelicula pelicula) {
    Navigator.pushNamed(context, 'show', arguments: pelicula);
  }
}
