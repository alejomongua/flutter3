import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  final List peliculas;

  CardSwiper({Key? key, required this.peliculas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Container(
        child: CarouselSlider.builder(
          itemCount: peliculas.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return Hero(
              tag: peliculas[index].getIdBackground(),
              child: _crearPelicula(context, peliculas[index]),
            );
          },
          options: CarouselOptions(
            aspectRatio: 2,
            autoPlay: true,
            enlargeCenterPage: true,
          ),
        ),
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
            image: pelicula.getBackgroundImage(),
            fit: BoxFit.cover,
          ),
        ),
      );
}
