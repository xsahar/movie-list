import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../widgets/movie_poster.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: MoviePoster(url: movie.poster, width: 220, height: 320),
            ),
          ),
          const SizedBox(height: 16),
          Text(movie.title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            '${movie.year}  •  ${movie.genre}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber),
              const SizedBox(width: 4),
              Text('${movie.imdbRating.toStringAsFixed(1)} / 10'),
              if (movie.imdbVotes.isNotEmpty)
                Text('  (${movie.imdbVotes} votes)'),
            ],
          ),
          const SizedBox(height: 16),
          if (movie.plot.isNotEmpty) ...[
            Text(movie.plot, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 16),
          ],
          _DetailRow(label: 'Released', value: movie.released),
          _DetailRow(label: 'Rated', value: movie.rated),
          _DetailRow(label: 'Runtime', value: movie.runtime),
          _DetailRow(label: 'Director', value: movie.director),
          _DetailRow(label: 'Writer', value: movie.writer),
          _DetailRow(label: 'Actors', value: movie.actors),
          _DetailRow(label: 'Language', value: movie.language),
          _DetailRow(label: 'Country', value: movie.country),
          _DetailRow(label: 'Awards', value: movie.awards),
          _DetailRow(label: 'Metascore', value: movie.metascore),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    if (value.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 2),
          Text(value),
        ],
      ),
    );
  }
}
