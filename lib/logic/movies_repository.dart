import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/constants/const.dart';
import 'package:movie_app/models/credit_model.dart';
import 'package:movie_app/models/movie_detail_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/video_model.dart';

class MovieRepository {
  final _apiParams = "?api_key=${Const.apiKey}&language=${Const.defLang}";

  Future<Movies> findPopularMovies(int page) async {
    final apiUrl = Const.baseUrlMovies + "popular" + _apiParams;
    print(apiUrl);
    var response = await http.get(apiUrl + "&page=$page");
    var result = jsonDecode(response.body);
    print(response.body);
    try {
      var movies = Movies.fromJson(result);
      return movies;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Movies> findTopRatedMovies(int page) async {
    final apiUrl = Const.baseUrlMovies + "top_rated" + _apiParams;
    print(apiUrl);
    var response = await http.get(apiUrl + "&page=$page");
    var result = jsonDecode(response.body);
    print(response.body);
    try {
      var movies = Movies.fromJson(result);
      return movies;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Movies> findUpcomingMovies(int page) async {
    final apiUrl = Const.baseUrlMovies + "upcoming" + _apiParams;
    print(apiUrl);
    var response = await http.get(apiUrl + "&page=$page");
    var result = jsonDecode(response.body);
    print(response.body);
    try {
      var movies = Movies.fromJson(result);
      return movies;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Movies> fetchMovies(int page, String movieCategory) async {
    final apiUrl = Const.baseUrlMovies + movieCategory + _apiParams;
    print(apiUrl);
    var response = await http.get(apiUrl + "&page=$page");
    var result = jsonDecode(response.body);
    print(response.body);
    try {
      var movies = Movies.fromJson(result);
      return movies;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<MovieDetail> getMovieDetail(int movieId) async {
    final apiUrl = Const.baseUrlMovies + movieId.toString() + _apiParams;
    print(apiUrl);
    var response = await http.get(apiUrl);
    var result = jsonDecode(response.body);
    print(response.body);
    try {
      var movie = MovieDetail.fromJson(result);
      return movie;
    } catch (e) {
      return null;
    }
  }

  Future<Movies> fetchSimilarMovies(int movieId) async {
    final apiUrl =
        Const.baseUrlMovies + movieId.toString() + "/similar" + _apiParams;
    print(apiUrl);
    var response = await http.get(apiUrl);
    var result = jsonDecode(response.body);
    print(response.body);
    try {
      var movies = Movies.fromJson(result);
      return movies;
    } catch (e) {
      return null;
    }
  }

  Future<Movies> fetchRecommendationMovies(int movieId) async {
    final apiUrl = Const.baseUrlMovies +
        movieId.toString() +
        "/recommendations" +
        _apiParams;
    print(apiUrl);
    var response = await http.get(apiUrl);
    var result = jsonDecode(response.body);
    print(response.body);
    try {
      var movies = Movies.fromJson(result);
      return movies;
    } catch (e) {
      return null;
    }
  }

  Future<Credit> getCredit(int movieId) async {
    final apiUrl =
        Const.baseUrlMovies + movieId.toString() + "/credits" + _apiParams;
    print(apiUrl);
    var response = await http.get(apiUrl);
    var result = jsonDecode(response.body);
    print(response.body);
    try {
      var credit = Credit.fromJson(result);
      return credit;
    } catch (e) {
      return null;
    }
  }

  Future<Movies> searchMovies(String searchQuery, int page) async {
    final apiUrl = Const.baseUrlSearch +
        _apiParams +
        "&query=" +
        searchQuery +
        "&page=" +
        page.toString();
    print(apiUrl);
    var response = await http.get(apiUrl);
    var result = jsonDecode(response.body);
    print(response.body);
    try {
      var results = Movies.fromJson(result);
      return results;
    } catch (e) {
      return null;
    }
  }

  Future<Videos> findVideos(int movieId) async {
    final apiUrl = Const.baseUrlMovies + "$movieId/videos" + _apiParams;
    print(apiUrl);
    var response = await http.get(apiUrl);
    var result = jsonDecode(response.body);
    print(response.body);
    try {
      var results = Videos.fromJson(result);
      return results;
    } catch (e) {
      return null;
    }
  }
}
