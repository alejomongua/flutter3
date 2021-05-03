import 'package:flutter/material.dart';

class Peliculas {
  List<Pelicula> peliculas = [];

  Peliculas(this.peliculas);

  Peliculas.fromJson(List<Map<String, dynamic>> json) {
    if (json == null) return;
    peliculas = json.map((element) => Pelicula.fromJson(element)).toList();
  }
}

class Pelicula {
  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Pelicula({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  Pelicula.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    // Se hace type casting a enteros
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    // Se divide entre 1 para hacer un cast a float
    popularity = json['popularity'] / 1.0;
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    // Se divide entre 1 para hacer un cast a float
    voteAverage = json['vote_average'] / 1.0;
    voteCount = json['vote_count'];
  }

  ImageProvider getPosterImage() {
    if (posterPath == null) {
      return AssetImage('assets/No_image_available_600_x_450.png');
    }

    return NetworkImage('https://image.tmdb.org/t/p/w500/$posterPath');
  }
}
