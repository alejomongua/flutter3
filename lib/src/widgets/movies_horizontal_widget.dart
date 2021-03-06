import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontalWidget extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguientePagina;

  const MovieHorizontalWidget({
    required this.peliculas,
    Key? key,
    required this.siguientePagina,
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
      padding: EdgeInsets.only(left: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: (context, i) =>
            _crearTarjeta(context, peliculas[i], height),
      ),
    );
  }

  Widget _crearTarjeta(context, Pelicula pelicula, height) {
    final _tarjeta = Container(
      margin: EdgeInsets.only(right: 15),
      child: Column(
        children: [
          Hero(
            tag: pelicula.getIdTarjeta(),
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
          Container(
            width: 120,
            child: Text(
              pelicula.title!,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
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
