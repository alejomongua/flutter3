import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/api_key.dart';

// En el archivo src/providers/api_key.dart se va a almacenar el api key
// genererado iniciando sesión en themoviedb.org. El único contenido de dicho
// archivo es:
// final apiKey = 'xxxxxxxxxxxxxxxxxxxxxxxxxxx';

class PeliculasProvider {
  final _apiKey = apiKey;
  final _url = 'api.themoviedb.org';
  final _language = 'es-ES';

  List<Pelicula> _peliculasPopulares = [];
  int _page = 1;

  final _streamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _streamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _streamController.stream;

  void disposeStreams() {
    _streamController?.close();
  }

  Future<List<Pelicula>> getNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });
    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopular() async {
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': (_page++).toString(),
    });

    final _peliculas = await _procesarRespuesta(url);

    _peliculasPopulares.addAll(_peliculas);

    popularesSink(_peliculasPopulares);

    return _peliculasPopulares;
  }

  _procesarRespuesta(url) async {
    final respuesta = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(respuesta.body);

    if (decodedData == null || decodedData['results'] == null) {
      return [];
    }

    final peliculas =
        Peliculas.fromJson(decodedData['results'].cast<Map<String, dynamic>>());

    return peliculas.peliculas;
  }
}
