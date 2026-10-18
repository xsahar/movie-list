// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:movie_list/models/movie.dart';
import 'package:movie_list/screens/movie_list_screen.dart';
import 'package:movie_list/services/movie_repository.dart';

void main() {
  const movies = [
    Movie(
      title: 'Avatar',
      year: '2009',
      director: 'James Cameron',
      imdbRating: 7.9,
    ),
    Movie(title: 'A Lower Rated Movie', imdbRating: 5.5),
  ];

  testWidgets('shows movies in rating order and searches case-insensitively', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MovieListScreen(repository: _TestMovieRepository(movies)),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Avatar'), findsOneWidget);
    expect(find.text('A Lower Rated Movie'), findsOneWidget);
    expect(
      tester.getTopLeft(find.text('Avatar')).dy,
      lessThan(tester.getTopLeft(find.text('A Lower Rated Movie')).dy),
    );

    await tester.enterText(find.byType(TextField), 'vAtAr');
    await tester.pumpAndSettle();

    expect(find.text('Avatar'), findsOneWidget);
    expect(find.text('A Lower Rated Movie'), findsNothing);
  });

  testWidgets('opens details when a movie is tapped', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MovieListScreen(repository: _TestMovieRepository(movies)),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Avatar'));
    await tester.pumpAndSettle();

    expect(find.text('James Cameron'), findsOneWidget);
    expect(find.textContaining('2009'), findsOneWidget);
  });
}

class _TestMovieRepository extends MovieRepository {
  const _TestMovieRepository(this.movies);

  final List<Movie> movies;

  @override
  Future<List<Movie>> loadMovies() async => movies;
}
