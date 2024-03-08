// ignore_for_file: prefer_const_declarations
import 'dart:convert';
import 'package:netflix_flutter/types/genre.dart';
import 'package:netflix_flutter/types/movies.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

final baseUrl = 'https://api.themoviedb.org/3/';
final apiKey = dotenv.env['API_KEY'];

Future<List<Movie>> getMovies(String movieName, List<Genre> genres) async {
  var query = '';

  if (movieName.isNotEmpty) {
    movieName = movieName.replaceAll(' ', '+');
    query =
        '${baseUrl}search/movie?api_key=$apiKey&query=$movieName&language=fr_FR&page=1';
  } else {
    query = '${baseUrl}movie/popular?api_key=$apiKey&language=fr_FR&page=1';
  }
  print(query);
  final response = await http.get(Uri.parse(query));

  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    final List<Movie> movies = [];
    print('movies');

    for (var movie in result['results']) {
      List<Genre> movieGenres = [];
      for (var genreId in movie['genre_ids']) {
        final Genre genre = genres.firstWhere(
            (element) => element.id == genreId,
            orElse: () => Genre(id: 0, name: 'Unknown'));

        if (genre.id != 0) {
          movieGenres.add(genre);
        }
      }

      movies.add(Movie(
        title: movie['title'],
        overview: movie['overview'],
        releaseDate: movie['release_date'],
        posterPath: movie['poster_path'],
        voteAverage: movie['vote_average'].toDouble(),
        genres: movieGenres,
      ));
    }
    print(movies);
    return movies;
  } else {
    throw Exception('Failed to load movies');
  }
}

Future<List<Genre>> getGenres() async {
  final query = '${baseUrl}genre/movie/list?api_key=$apiKey&language=fr_FR';
  final response = await http.get(Uri.parse(query));

  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    final List<Genre> genres = [];
    for (var genre in result['genres']) {
      genres.add(Genre(
        id: genre['id'],
        name: genre['name'],
      ));
    }

    return genres;
  } else {
    throw Exception('Failed to load genres');
  }
}
