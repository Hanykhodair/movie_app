import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/DetailsResponse.dart';
import 'package:movie_app/models/MovieDiscoverResponse.dart';
import 'package:movie_app/models/MoviesListResponsel.dart';
import 'package:movie_app/models/SearchResponse.dart';
import 'package:movie_app/models/SimilarResponse.dart';
import '../../../models/PopularResponse.dart';
import '../../../models/UpcomingResponse.dart';

import '../../../models/TopRatedResponse.dart';

class ApiManager {
  static Future<PopularResponse> getPopular() async {
    try {
      Uri url = Uri.parse(
          "https://api.themoviedb.org/3/movie/popular?api_key=948e93635e8b4138371ce174e1542fb7");
      http.Response response = await http.get(url);
      var jsonData = jsonDecode(response.body);
      PopularResponse popularResponse = PopularResponse.fromJson(jsonData);
      return popularResponse;
    }
    catch(e){
      print(e.toString());
      throw Exception();
    }
  }

  static Future<UpcomingResponse> getUpcoming() async {
    try {
      Uri url = Uri.parse(
          "https://api.themoviedb.org/3/movie/upcoming?api_key=948e93635e8b4138371ce174e1542fb7");
      http.Response response = await http.get(url);
      var jsonData = jsonDecode(response.body);
      UpcomingResponse upcomingResponse = UpcomingResponse.fromJson(jsonData);
      return upcomingResponse;
    }
    catch(e){
      print(e.toString());
      throw Exception();
    }
  }

  static Future<TopRatedResponse> getTopRated() async {
    try {
      Uri url = Uri.parse(
          "https://api.themoviedb.org/3/movie/top_rated?api_key=948e93635e8b4138371ce174e1542fb7");
      http.Response response = await http.get(url);
      var jsonData = jsonDecode(response.body);
      TopRatedResponse topRatedResponse = TopRatedResponse.fromJson(jsonData);
      return topRatedResponse;
    }
    catch(e){
      print(e.toString());
      throw Exception();
    }
  }

  static Future<DetailsResponse> getDetails(String movieId) async {
    try {
      Uri url = Uri.parse(
          "https://api.themoviedb.org/3/movie/$movieId?api_key=948e93635e8b4138371ce174e1542fb7");
      http.Response response = await http.get(url);
      var jsonData = jsonDecode(response.body);
      DetailsResponse detailsResponse = DetailsResponse.fromJson(jsonData);
      return detailsResponse;
    }
    catch (e){
      print(e.toString());
      throw Exception();
    }
  }

  static Future<SimilarResponse> getSimilar(String movieId) async {
    try {
      Uri url = Uri.parse(
          "https://api.themoviedb.org/3/movie/$movieId/similar?api_key=948e93635e8b4138371ce174e1542fb7");
      http.Response response = await http.get(url);
      var jsonData = jsonDecode(response.body);
      SimilarResponse similarResponse = SimilarResponse.fromJson(jsonData);
      return similarResponse;
    }
    catch(e){
      print(e.toString());
      throw Exception();
    }
  }

  static Future<SearchResponse> getMovie(String movieTitle) async {
    try {
      Uri url = Uri.parse(
          "https://api.themoviedb.org/3/search/movie?api_key=948e93635e8b4138371ce174e1542fb7&query=$movieTitle");
      http.Response response = await http.get(url);
      var jsonData = jsonDecode(response.body);
      SearchResponse searchResponse = SearchResponse.fromJson(jsonData);
      return searchResponse;
    } catch (e) {
      print(e.toString());
      throw Exception();
    }
  }

  static Future<MoviesListResponse> getMoviesList() async {
    try {
      Uri url = Uri.parse(
          "https://api.themoviedb.org/3/genre/movie/list?api_key=948e93635e8b4138371ce174e1542fb7");
      http.Response response = await http.get(url);
      var jsonData = jsonDecode(response.body);
      MoviesListResponse moviesListModel =
          MoviesListResponse.fromJson(jsonData);
      return moviesListModel;
    } catch (e) {
      print("${e.toString()} in getMoviesList");
      throw Exception();
    }
  }

 static Future<MovieDiscoverResponse> getMovieDiscover(String id) async {
    try {
      Uri url = Uri.parse(
          "https://api.themoviedb.org/3/discover/movie?api_key=948e93635e8b4138371ce174e1542fb7&with_genres=$id");
      http.Response response = await http.get(url);
      var jsonData = jsonDecode(response.body);
      MovieDiscoverResponse movieDiscoverResponse =
          MovieDiscoverResponse.fromJson(jsonData);
      return movieDiscoverResponse;
    } catch (e) {
      print(e.toString());
      throw Exception();
    }
  }
}
