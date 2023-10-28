import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/DetailsResponse.dart';
import 'package:movie_app/models/SearchResponse.dart';
import 'package:movie_app/models/SimilarResponse.dart';
import '../../../models/PopularResponse.dart';
import '../../../models/UpcomingResponse.dart';

import '../../../models/TopRatedResponse.dart';

// https://api.themoviedb.org/3/movie/top_rated?api_key=948e93635e8b4138371ce174e1542fb7
class ApiManager {
  static Future<PopularResponse> getPopular() async {
    Uri url = Uri.parse(
        "https://api.themoviedb.org/3/movie/popular?api_key=948e93635e8b4138371ce174e1542fb7");
    http.Response response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    PopularResponse popularResponse = PopularResponse.fromJson(jsonData);
    return popularResponse;
  }

  static Future<UpcomingResponse> getUpcoming() async {
    Uri url = Uri.parse(
        "https://api.themoviedb.org/3/movie/upcoming?api_key=948e93635e8b4138371ce174e1542fb7");
    http.Response response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    UpcomingResponse upcomingResponse = UpcomingResponse.fromJson(jsonData);
    return upcomingResponse;
  }

  static Future<TopRatedResponse> getTopRated() async {
    Uri url = Uri.parse(
        "https://api.themoviedb.org/3/movie/top_rated?api_key=948e93635e8b4138371ce174e1542fb7");
    http.Response response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    TopRatedResponse topRatedResponse = TopRatedResponse.fromJson(jsonData);
    return topRatedResponse;
  }

  static Future<DetailsResponse> getDetails(String movieId) async {
    Uri url = Uri.parse(
        "https://api.themoviedb.org/3/movie/$movieId?api_key=948e93635e8b4138371ce174e1542fb7");
    http.Response response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    DetailsResponse detailsResponse = DetailsResponse.fromJson(jsonData);
    return detailsResponse;
  }

  static Future<SimilarResponse> getSimilar(String movieId) async {
    Uri url = Uri.parse(
        "https://api.themoviedb.org/3/movie/$movieId/similar?api_key=948e93635e8b4138371ce174e1542fb7");
    http.Response response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    SimilarResponse similarResponse = SimilarResponse.fromJson(jsonData);
    return similarResponse;
  }

  static Future<SearchResponse> getMovie(String movieTitle) async {
    Uri url = Uri.parse(
        "https://api.themoviedb.org/3/search/movie?api_key=948e93635e8b4138371ce174e1542fb7&query=$movieTitle");
    http.Response response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    SearchResponse searchResponse = SearchResponse.fromJson(jsonData);
    return searchResponse;
  }
}
