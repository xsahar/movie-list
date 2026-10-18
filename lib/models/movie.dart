class Movie {
  const Movie({
    required this.title,
    this.year = '',
    this.rated = '',
    this.released = '',
    this.runtime = '',
    this.genre = '',
    this.director = '',
    this.writer = '',
    this.actors = '',
    this.plot = '',
    this.language = '',
    this.country = '',
    this.awards = '',
    this.poster = '',
    this.metascore = '',
    this.imdbRating = 0,
    this.imdbVotes = '',
  });

  final String title;
  final String year;
  final String rated;
  final String released;
  final String runtime;
  final String genre;
  final String director;
  final String writer;
  final String actors;
  final String plot;
  final String language;
  final String country;
  final String awards;
  final String poster;
  final String metascore;
  final double imdbRating;
  final String imdbVotes;

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: _readString(json['Title']),
      year: _readString(json['Year']),
      rated: _readString(json['Rated']),
      released: _readString(json['Released']),
      runtime: _readString(json['Runtime']),
      genre: _readString(json['Genre']),
      director: _readString(json['Director']),
      writer: _readString(json['Writer']),
      actors: _readString(json['Actors']),
      plot: _readString(json['Plot']),
      language: _readString(json['Language']),
      country: _readString(json['Country']),
      awards: _readString(json['Awards']),
      poster: _readString(json['Poster']),
      metascore: _readString(json['Metascore']),
      imdbRating: double.tryParse(_readString(json['imdbRating'])) ?? 0,
      imdbVotes: _readString(json['imdbVotes']),
    );
  }

  static String _readString(Object? value) => value is String ? value : '';
}
