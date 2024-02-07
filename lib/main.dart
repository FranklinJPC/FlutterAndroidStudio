import 'package:flutter/material.dart';
import 'package:movies/api/endpoints.dart';
import 'package:movies/modal_class/function.dart';
import 'package:movies/modal_class/genres.dart';
import 'package:movies/modal_class/movie.dart';
import 'package:movies/screens/movie_detail.dart';
import 'package:movies/screens/search_view.dart';
import 'package:movies/screens/settings.dart';
import 'package:movies/screens/widgets.dart';
import 'package:movies/theme/theme_state.dart';
import 'package:provider/provider.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeState>(
      create: (_) => ThemeState(),
      child: MaterialApp(
        title: 'World of Movies 🎬',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue, canvasColor: Colors.transparent),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Genres> _genres = [];
  @override
  void initState() {
    super.initState();
    fetchGenres().then((value) {
      _genres = value.genres ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ThemeState>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: state.themeData.colorScheme.secondary,
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        centerTitle: true,
        title: Text(
          '🌟 Welcome to the World of Movies! 🎬🍿',
          style: TextStyle(
            fontSize: state.themeData.textTheme.headline5!.fontSize,
            fontWeight: state.themeData.textTheme.headline5!.fontWeight,
          //  color: Colors.blue, // Puedes ajustar el color según tus preferencias
            fontStyle: FontStyle.italic,
            // Otros estilos que desees agregar
          ),
        ),
        backgroundColor: state.themeData.primaryColor,
        actions: <Widget>[
          IconButton(
            color: state.themeData.colorScheme.secondary,
            icon: Icon(Icons.search),
            onPressed: () async {
              final Movie? result = await showSearch<Movie?>(
                  context: context,
                  delegate:
                  MovieSearch(themeData: state.themeData, genres: _genres));
              if (result != null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MovieDetailPage(
                            movie: result,
                            themeData: state.themeData,
                            genres: _genres,
                            heroId: '${result.id}search')));
              }
            },
          )
        ],
      ),
      drawer: Drawer(
        child: SettingsPage(),
      ),

      body: Container(
        color: state.themeData.primaryColor,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            // Widget: DiscoverMovies

            Card(
              elevation: 5.0,
              margin: EdgeInsets.symmetric(vertical: 10.0),
              color: state.themeData.cardColor.withOpacity(0.9), // Ajusta la opacidad según tu preferencia
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Discover Movies',
                      style: state.themeData.textTheme.headline6!.copyWith(
                        // Ajusta el estilo del texto según tus preferencias
                        fontWeight: FontWeight.bold,
                        color: state.themeData.primaryColorDark,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    DiscoverMovies(
                      themeData: state.themeData,
                      genres: _genres,
                    ),
                  ],
                ),
              ),
            ),

            // Widget: ScrollingMovies (Top Rated)
            Card(
              elevation: 5.0,
              margin: EdgeInsets.symmetric(vertical: 10.0),
              color: state.themeData.cardColor.withOpacity(0.9), // Ajusta la opacidad según tu preferencia
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Top Rated',
                      style: state.themeData.textTheme.headline6!.copyWith(
                        // Ajusta el estilo del texto según tus preferencias
                        fontWeight: FontWeight.bold,
                        color: state.themeData.primaryColorDark,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    ScrollingMovies(
                      themeData: state.themeData,
                      title: 'Top Rated',
                      api: Endpoints.topRatedUrl(1),
                      genres: _genres,
                    ),
                  ],
                ),
              ),
            ),

            // Widget: ScrollingMovies (Now Playing)
            Card(
              elevation: 5.0,
              margin: EdgeInsets.symmetric(vertical: 10.0),
              color: state.themeData.cardColor.withOpacity(0.9), // Ajusta la opacidad según tu preferencia
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Now Playing',
                      style: state.themeData.textTheme.headline6!.copyWith(
                        // Ajusta el estilo del texto según tus preferencias
                        fontWeight: FontWeight.bold,
                        color: state.themeData.primaryColorDark,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    ScrollingMovies(
                      themeData: state.themeData,
                      title: 'Now Playing',
                      api: Endpoints.nowPlayingMoviesUrl(1),
                      genres: _genres,
                    ),
                  ],
                ),

              ),
            ),

            // Widget: ScrollingMovies (Upcoming Movies - Commented out)
            Card(
              elevation: 5.0,
              margin: EdgeInsets.symmetric(vertical: 10.0),
              color: state.themeData.cardColor.withOpacity(0.9), // Ajusta la opacidad según tu preferencia
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Upcoming Movies',
                      style: state.themeData.textTheme.headline6!.copyWith(
                        // Ajusta el estilo del texto según tus preferencias
                        fontWeight: FontWeight.bold,
                        color: state.themeData.primaryColorDark,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    ScrollingMovies(
                      themeData: state.themeData,
                      title: 'Upcoming Movies',
                      api: Endpoints.upcomingMoviesUrl(1),
                      genres: _genres,
                    ),
                  ],
                ),
              ),
            ),

            // Widget: ScrollingMovies (Popular)
            Card(
              elevation: 5.0,
              margin: EdgeInsets.symmetric(vertical: 10.0),
              color: state.themeData.cardColor.withOpacity(0.9), // Ajusta la opacidad según tu preferencia
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Popular',
                      style: state.themeData.textTheme.headline6!.copyWith(
                        // Ajusta el estilo del texto según tus preferencias
                        fontWeight: FontWeight.bold,
                        color: state.themeData.primaryColorDark,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    ScrollingMovies(
                      themeData: state.themeData,
                      title: 'Popular',
                      api: Endpoints.popularMoviesUrl(1),
                      genres: _genres,
                    ),
                  ],
                ),
              ),
            ),









          ],
        ),
      ),

    );
  }
}
