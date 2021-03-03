import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/constants/const.dart';
import 'package:movie_app/models/movie_detail_model.dart';
import 'package:movie_app/models/movie_model.dart';

class MovieRepository {
  final _apiParams = "?api_key=${Const.apiKeyMdb}&language=${Const.defLangMdb}";
  
  Future<PopularMovies> findPopularMovies(int page) async {
    final apiUrl = Const.baseUrlMdb + "popular" + _apiParams;
    var response = await http.get(apiUrl + "&page=$page");
    var result = jsonDecode(response.body);
    try {
      var movies = PopularMovies.fromJson(result);
      return movies;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<PopularMovies> findTopRatedMovies(int page) async {
    final apiUrl = Const.baseUrlMdb + "top_rated" + _apiParams;
    var response = await http.get(apiUrl + "&page=$page");
    var result = jsonDecode(response.body);
    try {
      var movies = PopularMovies.fromJson(result);
      return movies;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<MovieDetail> getMovieDetail(int movieId) async {
    final apiUrl = Const.baseUrlMdb + movieId.toString() + _apiParams;
    var response = await http.get(apiUrl);
    var result = jsonDecode(response.body);
    try {
      var movie = MovieDetail.fromJson(result);
      return movie;
    } catch (e) {
      return null;
    }
  }
}