import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movies_horizontal_widget.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = PeliculasProvider();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopular();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Cartelera'),
        backgroundColor: Colors.blueGrey[800],
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MovieSearchDelegate(),
                );
              }),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 10),
              _swiperTarjetas(),
              SizedBox(height: 20),
              _footer(context),
            ],
          ),
        ),
      ),
    );
  }

  _swiperTarjetas() => FutureBuilder(
        future: peliculasProvider.getNowPlaying(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) return CardSwiper(peliculas: snapshot.data);

          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
            height: 400,
          );
        },
      );

  _footer(context) => Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                'Pel??culas populares',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder(
              stream: peliculasProvider.popularesStream,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return MovieHorizontalWidget(
                    peliculas: snapshot.data,
                    siguientePagina: peliculasProvider.getPopular,
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      );
}
