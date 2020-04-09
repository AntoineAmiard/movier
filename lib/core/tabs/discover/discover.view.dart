import 'package:flutter/material.dart';
import 'package:movie_helper/core/tabs/components/appbar.comp.dart';
import 'package:movie_helper/core/tabs/discover/components/divider.comp.dart';
import 'package:movie_helper/core/tabs/discover/components/genres.comp.dart';

import 'package:movie_helper/core/tabs/discover/components/medias.comp.dart';
import 'package:movie_helper/core/tabs/discover/components/sliver-bloc-list.comp.dart';
import 'package:movie_helper/models/discover.models.dart';
import 'package:movie_helper/services/http.service.dart';

class DiscoverView extends StatefulWidget {
  @override
  _DiscoverViewState createState() => _DiscoverViewState();
}

class _DiscoverViewState extends State<DiscoverView> {
  HttpService httpService = new HttpService();
  Discover data;

  @override
  void initState() {
    loadData().then((data) => setState(() => this.data = data));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return this.data == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            child: CustomScrollView(
              slivers: <Widget>[
                CustomAppBar(
                  title: "Découverte",
                  topLeftColor: Colors.blue,
                  bottomRightColor: Colors.cyan,
                ),
                SliverDivider(title: "Film"),
                SliverBloc(
                  title: "Actuellement en salle",
                  list: DiscoverList.fromMovie(
                    movies: data.nowPlayingMovies,
                  ),
                  maxHeight: 300,
                  minHeight: 240,
                ),
                SliverBloc(
                  title: "Les plus populaires",
                  list: DiscoverList.fromMovie(
                    movies: data.popularMovies,
                  ),
                  maxHeight: 300,
                  minHeight: 240,
                ),
                SliverBloc(
                  title: "Les mieux notés",
                  list: DiscoverList.fromMovie(
                    movies: data.topRatedMovies,
                  ),
                  maxHeight: 300,
                  minHeight: 240,
                ),
                SliverBloc(
                  title: "Par genre",
                  icon: Icons.chevron_right,
                  list: Genres(
                    genres: data.genresMovie,
                    mediaType: "movie",
                  ),
                  maxHeight: 100,
                  minHeight: 100,
                ),
                SliverDivider(title: "TV"),
                SliverBloc(
                  title: "Les plus populaires",
                  list: DiscoverList.fromTv(
                    tvs: data.popularTv,
                  ),
                  maxHeight: 300,
                  minHeight: 240,
                ),
                SliverBloc(
                  title: "Les mieux notés",
                  list: DiscoverList.fromTv(
                    tvs: data.topRatedTv,
                  ),
                  maxHeight: 300,
                  minHeight: 240,
                ),
                SliverBloc(
                  title: "Par genre",
                  icon: Icons.chevron_right,
                  list: Genres(
                    genres: data.genresTv,
                    mediaType: "tv",
                  ),
                  maxHeight: 100,
                  minHeight: 100,
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 100,
                  ),
                ),
              ],
            ),
            onRefresh: loadData,
          );
  }

  Future<Discover> loadData() async {
    return Discover(
      nowPlayingMovies: await httpService.getNowPlayingMovies(),
      popularMovies: await httpService.getPopularMovies(),
      topRatedMovies: await httpService.getTopRatedMovies(),
      genresMovie: await httpService.getGenreMovie(),
      popularTv: await httpService.getPopularTV(),
      topRatedTv: await httpService.getTopRatedTV(),
      genresTv: await httpService.getGenreTV(),
    );
  }

  Future<void> onRefresh() async {
    setState(() async => this.data = await loadData());
  }
}
