import 'package:flutter/material.dart';
import 'package:netflix_flutter/types/movies.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:netflix_flutter/utils/api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  late List<Movie> _movies = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Netlix', style: TextStyle(color: Colors.red)),
        backgroundColor: Colors.black,
        leading: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset('assets/images/netflix_logo.png')),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Rechercher un film',
            onPressed: () {
              Alert(
                  context: context,
                  title: "Search",
                  style: const AlertStyle(
                    titleStyle: TextStyle(color: Colors.red, fontSize: 20.0),
                  ),
                  content: Column(
                    children: <Widget>[
                      TextField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.search),
                          labelText: 'Name of the movie',
                        ),
                        controller: _searchController,
                      ),
                    ],
                  ),
                  buttons: [
                    DialogButton(
                      onPressed: () {
                        getMovies(_searchController.text).then((value) {
                          setState(() {
                            _movies = value;
                            _searchController.clear();
                          });
                        });
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Search",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
                  ]).show();
            },
          ),
        ],
      ),
      body: GridView.builder(
        itemCount: _movies.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200.0,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/movie', arguments: _movies[index]);
            },
            child: Card(
              elevation: 5.0,
              child: Image.network(
                _movies[index].posterPath == null
                    ? 'https://image.tmdb.org/t/p/w200/8Y43P0KjjKDGI9MH89NWONA.jpg'
                    : 'https://image.tmdb.org/t/p/w500${_movies[index].posterPath}',
                fit: BoxFit.fill,
              ),
            ),
          );
        },
      ),
    );
  }
}
