# Movie List Project Guide

## What we are building

A small Flutter app that reads movie information from `assets/movies.json`. It
will show the highest-rated movies first, let people search by movie name, and
open a page with more information when a movie is tapped.

The JSON file is already in the `assets` folder and is listed in
`pubspec.yaml`. Flutter bundles it with the app; it is not downloaded from the
internet when the app runs. Movie poster pictures use web addresses in the JSON,
so displaying those pictures requires an internet connection.

## The idea in plain English

- **JSON file:** the collection of movie facts, stored as text.
- **Movie model:** a Dart class that gives each movie's facts clear names and
  types.
- **Data loader:** reads the bundled JSON file and turns its text into Movie
  objects.
- **Screens:** Flutter widgets that show the movie list and movie details.
- **Search:** filters the list by movie title without caring about uppercase or
  lowercase letters.

## How the parts connect

```text
assets/movies.json
        |
        v
Data loader reads and decodes the JSON
        |
        v
Movie model objects
        |
        v
Home screen: sort by rating -> search by title -> show movie list
        |
        | tap a movie
        v
Movie details screen
```

## Build it step by step

1. **Keep the movie data available**
   - The file is at `assets/movies.json`.
   - `pubspec.yaml` must list `assets/movies.json` under `flutter` > `assets`.
   - If the asset list changes, run `flutter pub get`.

2. **Create a Movie model**
   - Add fields for the movie information the app needs, such as title, year,
     genre, rating, poster, actors, director, and plot.
   - Add a `fromJson` method to create a Movie from one JSON object.
   - JSON keys use names such as `Title` and `imdbRating`; match those exact
     names when reading the data.

3. **Load the movies**
   - Read `assets/movies.json` with Flutter's asset loader.
   - Decode the JSON text and convert each item into a Movie.
   - Keep loading asynchronous because reading an asset takes time.

4. **Build the home screen**
   - Show a search box and a scrollable list of movies.
   - Sort movies by their numeric IMDb rating, highest first.
   - Each list item should show its poster, title, and genre.
   - Search the title case-insensitively, so `vatar` can find `Avatar`.

5. **Build the details screen**
   - Open it when someone taps a movie.
   - Show the movie title in the app bar and provide normal back navigation.
   - Show the poster and at least five useful details, for example year,
     rating, runtime, genre, director, actors, and plot.
   - Make the page scroll so its content does not overflow a small screen.

6. **Handle loading and errors**
   - Show a loading indicator while the file is being read.
   - Show a clear error message if the file cannot be read or decoded.
   - Use a placeholder if a poster image cannot load.

7. **Run and check the app**
   - Run `flutter pub get`, then start the app on an emulator or device.
   - Check that ratings are in descending order, search ignores letter case,
     tapping opens the correct details, and both screens fit on small screens.

## Where the project is now

The app is now split into small, focused files:

```text
lib/
  main.dart                    Starts the app and sets its theme
  models/movie.dart            Describes a movie and reads its JSON fields
  services/movie_repository.dart Loads and sorts the bundled movie data
  screens/
    movie_list_screen.dart     Shows, searches, and opens the movie list
    movie_details_screen.dart  Shows information about one selected movie
  widgets/
    movie_card.dart            Reusable row for one movie
    movie_poster.dart          Shows a poster or a fallback icon
test/
  movie_repository_test.dart   Checks that movie data loads in rating order
  widget_test.dart             Checks searching and opening movie details
```

The movie JSON asset is registered in `pubspec.yaml`. The list, case-insensitive
search, rating order, movie detail page, and poster fallback are implemented.
