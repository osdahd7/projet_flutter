

import 'dart:convert';

import '../main.dart';
import 'package:http/http.dart' as http;

Future<MovieList> fetchPhotos() async {
  final response =
  await http.get('https://api.themoviedb.org/3/movie/popular?api_key=62feaff3d2cf094a340f530fbf25bde9');

  if(response.statusCode == 200)
  {
    var json = jsonDecode(response.body);
    var result = json['results'];
    return MovieList.fromJson(result);
  }
  else{
    throw Exception("404");
  }

  // Use the compute function to run parsePhotos in a separate isolate.

}
Future<Album> get_movie_details(var id) async {
  final response =
  await http.get('https://api.themoviedb.org/3/movie/'+id+'?api_key=62feaff3d2cf094a340f530fbf25bde9');

  if(response.statusCode == 200)
  {
    var json = jsonDecode(response.body);

    return Album.fromJson(json);
  }
  else{
    throw Exception("404");
  }

}

Future<Genre_movies> get_movie_genre(var id) async {
  final response =
  await http.get('https://api.themoviedb.org/3/movie/' + id +
      '?api_key=62feaff3d2cf094a340f530fbf25bde9');

  if (response.statusCode == 200) {
    var json = jsonDecode(response.body);
    var result = json['genres'];
    return Genre_movies.fromJson(json);
  }
  else {
    throw Exception("404");
  }
}