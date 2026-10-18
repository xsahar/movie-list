import 'package:flutter_test/flutter_test.dart';
import 'package:movie_list/services/movie_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'loads movies from the bundled JSON in descending rating order',
    () async {
      final movies = await const MovieRepository().loadMovies();

      expect(movies, isNotEmpty);
      for (var index = 1; index < movies.length; index++) {
        expect(
          movies[index - 1].imdbRating,
          greaterThanOrEqualTo(movies[index].imdbRating),
        );
      }
    },
  );
}
