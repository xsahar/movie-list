import 'package:flutter/material.dart';

import 'screens/movie_list_screen.dart';

void main() {
  runApp(const MovieListApp());
}

class MovieListApp extends StatelessWidget {
  const MovieListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD95D39),
          surface: const Color(0xFFFAF7F2),
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFAF7F2),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFAF7F2),
          foregroundColor: Color(0xFF25232A),
          surfaceTintColor: Colors.transparent,
        ),
      ),
      home: const MovieListScreen(),
    );
  }
}
