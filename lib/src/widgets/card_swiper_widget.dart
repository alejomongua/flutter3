import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  final List peliculas;

  CardSwiper({Key key, @required this.peliculas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.5,
        itemHeight: _screenSize.height * 0.4,
        itemBuilder: (BuildContext context, int index) {
          peliculas[index].uniqueId = '${peliculas[index].id}-cs';
          return Hero(
            tag: peliculas[index].uniqueId,
            child: _crearPelicula(context, peliculas[index]),
          );
        },
        itemCount: peliculas.length,
        // pagination: SwiperPagination(),
        // control: SwiperControl(),
      ),
    );
  }

  _crearPelicula(context, Pelicula pelicula) => GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, 'show', arguments: pelicula);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            placeholder: AssetImage('assets/No_image_available_600_x_450.png'),
            image: pelicula.getPosterImage(),
            fit: BoxFit.cover,
          ),
        ),
      );
}
