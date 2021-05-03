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

  Future<List<Pelicula>> getNowPlaying() async {
    final url = _getFullUrl('movie/now_playing');

    final respuesta = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(respuesta.body);

    if (decodedData == null || decodedData['results'] == null) {
      return [];
    }

    final peliculas =
        Peliculas.fromJson(decodedData['results'].cast<Map<String, dynamic>>());

    print(peliculas);
    return peliculas.peliculas;
  }

  Future<List<Pelicula>> getPopular() async {
    final url = _getFullUrl('movie/popular');

    final respuesta = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(respuesta.body);

    if (decodedData == null || decodedData['results'] == null) {
      return [];
    }

    final peliculas =
        Peliculas.fromJson(decodedData['results'].cast<Map<String, dynamic>>());

    print(peliculas);
    return peliculas.peliculas;
  }

  _getFullUrl(endpoint) {
    return Uri.https(_url, '3/$endpoint', {
      'api_key': _apiKey,
      'language': _language,
    });
  }
}
