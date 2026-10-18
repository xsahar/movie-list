import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../widgets/movie_poster.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: colors.primary.withValues(alpha: 0.12),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: MoviePoster(url: movie.poster, width: 220, height: 320),
              ),
            ),
          ),
          const SizedBox(height: 22),
          Text(
            movie.title,
            style: Theme.of(context).textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Text(
            '${movie.year}  •  ${movie.genre}',
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(color: colors.onSurfaceVariant),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star_rounded, color: Color(0xFFCF7B14)),
              const SizedBox(width: 4),
              Text(
                '${movie.imdbRating.toStringAsFixed(1)} / 10',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              if (movie.imdbVotes.isNotEmpty) ...[
                const SizedBox(width: 6),
                Text(
                  '(${movie.imdbVotes} votes)',
                  style: TextStyle(color: colors.onSurfaceVariant),
                ),
              ],
            ],
          ),
          const SizedBox(height: 20),
          if (movie.plot.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF1E9),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                movie.plot,
                style: Theme.of(context).textTheme.bodyLarge
                    ?.copyWith(height: 1.5),
              ),
            ),
            const SizedBox(height: 18),
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
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 4),
            Text(value),
          ],
        ),
      ),
    );
  }
}
