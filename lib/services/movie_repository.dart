import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/movie.dart';

class MovieRepository {
  const MovieRepository();

  Future<List<Movie>> loadMovies() async {
    final contents = await rootBundle.loadString('assets/movies.json');
    final decoded = jsonDecode(contents);

    if (decoded is! List<dynamic>) {
      throw const FormatException('The movie data must be a JSON list.');
    }

    final movies = decoded.map((item) {
      if (item is! Map<String, dynamic>) {
        throw const FormatException(
          'Each movie in the JSON file must be an object.',
        );
      }
      return Movie.fromJson(item);
    }).toList();

    movies.sort(
      (first, second) => second.imdbRating.compareTo(first.imdbRating),
    );
    return movies;
  }
}
