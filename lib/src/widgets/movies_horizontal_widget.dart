import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontalWidget extends StatelessWidget {
  final List<Pelicula> peliculas;

  const MovieHorizontalWidget({@required this.peliculas, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final height = screenSize.height * 0.3;
    return Container(
      height: height,
      child: PageView(
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3,
        ),
        children: _createTarjetas(height),
      ),
    );
  }

  _createTarjetas(height) => peliculas
      .map((Pelicula pelicula) => Container(
            margin: EdgeInsets.only(right: 15),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: FadeInImage(
                    placeholder:
                        AssetImage('assets/No_image_available_600_x_450.png'),
                    image: pelicula.getPosterImage(),
                    fit: BoxFit.cover,
                    height: height - 50,
                  ),
                ),
                //SizedBox(height: 10),
                Text(
                  pelicula.title,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ))
      .toList();
}
