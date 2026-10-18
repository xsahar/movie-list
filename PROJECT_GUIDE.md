# Movie List Project Guide

## Project overview

Movie List is a Flutter app that reads movie records from `assets/movies.json`.
It displays the movies in descending IMDb-rating order, lets the user search
titles, and opens a page with more information when a movie is selected.

The JSON file is bundled with the app through the asset entry in
`pubspec.yaml`. The movie data is available offline, but poster URLs point to
the internet, so posters need a network connection.

The interface uses a warm, light background with terracotta accents, amber
rating badges, and rounded movie cards. The list screen has a colorful welcome
banner, while the details screen gives the poster and plot their own visual
sections.

## How the data becomes a screen

```text
assets/movies.json
       |
       v
MovieRepository reads and decodes the JSON
       |
       v
Movie.fromJson creates a Movie object for each record
       |
       v
MovieListScreen sorts/displays the movies and filters search results
       |
       | user taps a movie
       v
MovieDetailsScreen displays that Movie's information
```

Each movie is written once in the JSON data file, not as a Dart object in the
app code. The Dart model describes the shape of one movie. At runtime, the
repository converts every JSON record into an object of that model, and the
screens display the object fields they need.

## JSON-to-Dart conversion

[JSON to Dart](https://jsontodart.com/) was used to generate a starting model
from a movie object in `assets/movies.json`. Converting JSON to Dart is useful
because it generates the class fields and JSON-key mappings, avoiding
handwriting every mapping. The generated output still needs review: a converter
does not know which properties the app uses or what types the rest of the code
expects.

The generated model for this project was adjusted to fit the app:

- The generated class was named `movies`; the app expects `Movie`, following
  Dart's capitalized class-name convention.
- The app expects the factory constructor `Movie.fromJson(...)`, which
  `MovieRepository` calls for each JSON record.
- The generated `imdbRating` was a `String`. The app sorts and displays ratings
  numerically, so the model uses a `double`.
- Optional text fields have safe defaults so screen code can use them without
  nullable-value checks everywhere.
- The JSON property names retain their exact spelling and capitalization.
  For example, `json['Title']` is assigned to the Dart field `title`.
- The generated `toJson` method and fields not used by the current screens are
  not needed for this read-only app. They can be added later if the app needs
  to write movie records or show those properties.

One record contains `"imdbRating": "N/A"`. The current model converts a rating
that cannot be parsed into `0`, which causes that movie to show as `0.0` and
sort to the bottom. This is a fallback, not the movie's actual rating.

## Main project files

| File | Purpose |
|---|---|
| `assets/movies.json` | Source data: a list of movie records and their properties. |
| `pubspec.yaml` | Declares Flutter settings and includes `assets/movies.json` in the app bundle. |
| `lib/main.dart` | Starts the app, configures its warm color theme, and opens the movie list screen. |
| `lib/models/movie.dart` | Defines the `Movie` data model and maps JSON values to Dart fields. |
| `lib/services/movie_repository.dart` | Loads and decodes the asset, creates movie objects, and sorts by rating. |
| `lib/screens/movie_list_screen.dart` | Shows the home screen, search box, loading/error states, and movie list. |
| `lib/screens/movie_details_screen.dart` | Shows the selected movie's poster and available details. |
| `lib/widgets/movie_card.dart` | Reusable list item showing a poster, title, genre, and rating. |
| `lib/widgets/movie_poster.dart` | Loads a poster from its URL or shows a placeholder if it is missing or fails to load. |
| `test/movie_repository_test.dart` | Checks that the JSON loads and ratings are sorted from high to low. |
| `test/widget_test.dart` | Checks rating order, case-insensitive search, and opening movie details. |

## Important concepts in the implementation

### Asynchronous loading

Reading an asset takes time, so `MovieRepository.loadMovies()` returns a
`Future<List<Movie>>`. The list screen uses `FutureBuilder` to show a loading
indicator while the future is unfinished, an error message if it fails, and
the list when data is ready.

### Sorting and unrated values

The repository sorts the parsed numeric ratings from highest to lowest before
returning them. Since `"N/A"` is currently converted to `0`, it appears below
movies with a real rating.

### ILIKE-style title search

The case-insensitive partial search is in
`lib/screens/movie_list_screen.dart`. It trims the search text, converts both
the search and each movie title to lowercase, and uses `contains()`:

```dart
final query = _searchText.trim().toLowerCase();
final movies = snapshot.data!
    .where((movie) => movie.title.toLowerCase().contains(query))
    .toList();
```

For example, searching for `vAtAr` matches `Avatar`. This is similar to SQL
`ILIKE '%query%'`, but it filters the in-memory Dart list; it does not use a
database.

### Screens, navigation, and scrolling

The home screen creates a movie card for each result. Tapping a card pushes a
details screen and passes the selected `Movie` object to it. The details page
uses a scrollable list so longer descriptions can fit on smaller screens.
Flutter's normal route behavior provides back navigation.

## Running and checking the app

From the project folder:

```text
flutter pub get
flutter run
```

To run the automated checks:

```text
flutter analyze
flutter test
```
