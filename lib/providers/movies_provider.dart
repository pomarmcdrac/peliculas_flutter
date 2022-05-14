import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/popular_response.dart';

import '../models/models.dart';

class MoviesProvider extends ChangeNotifier {

  final String _apiKey    = '3a55de6f5dc861005533539fc1b985dc';
  final String _baseUrl   = 'api.themoviedb.org';
  final String _language  = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  int _popularPage = 0;

  MoviesProvider() {
    print('MoviesProvider inicializado');

    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Future <String> _getJsonData( String endpoint, [int page = 1] ) async {
    var url = Uri.https( _baseUrl , endpoint , {
      'api_key': _apiKey,
      'language': _language,
      'page':'$page',
      });
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
  
    final jsonData = await this._getJsonData('3/movie/popular');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();

  }

  getPopularMovies() async {

    _popularPage++;

    final jsonData = await this._getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);

    popularMovies = [ ...popularMovies, ...popularResponse.results ];

    notifyListeners();

  }

}