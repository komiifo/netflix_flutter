import 'package:flutter/material.dart';
import 'package:netflix_flutter/types/movies.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Movie;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(movie.title ?? 'Movie',
            style: const TextStyle(color: Colors.red)),
      ),
      body: Column(
        children: [
          movie.posterPath == null
              ? const Text('No image')
              : Expanded(
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    fit: BoxFit.cover,
                  ),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var genre in movie.genres ?? [])
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chip(
                    label: Text(genre.name),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movie.overview ?? 'No overview',
              style: const TextStyle(fontSize: 20.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Release date: ${movie.releaseDate ?? 'No release date'}',
              style: const TextStyle(fontSize: 20.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Vote average: ${movie.voteAverage ?? 'No vote average'}',
              style: const TextStyle(fontSize: 20.0),
            ),
          )
        ],
      ),
    );
  }
}
