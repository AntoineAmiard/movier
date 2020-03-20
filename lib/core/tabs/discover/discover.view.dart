import 'package:flutter/material.dart';

import 'package:movie_helper/core/tabs/discover/components/horizontal-genre-list.comp.dart';
import 'package:movie_helper/core/tabs/discover/components/horizontal-overview-list.comp.dart';
import 'package:movie_helper/core/tabs/discover/components/sliver-app-bar.comp.dart';
import 'package:movie_helper/core/tabs/discover/components/sliver-bloc-list.comp.dart';
import 'package:movie_helper/core/tabs/discover/components/sliver-divider.comp.dart';
import 'package:movie_helper/core/tabs/discover/models/data-discover.models.dart';
import 'package:movie_helper/services/http.service.dart';

class DiscoverView extends StatefulWidget {
  @override
  _DiscoverViewState createState() => _DiscoverViewState();
}

class _DiscoverViewState extends State<DiscoverView> {
  HttpService httpService = new HttpService();
  DataDiscoverView data;

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
                SliverCustomAppBar(),
                SliverDivider(title: "Film"),
                SliverBloc(
                  title: "Actuellement en salle",
                  list: HorizontalOverviewList(
                    list: data.nowPlayingMovies,
                  ),
                  maxHeight: 300,
                  minHeight: 240,
                ),
                SliverBloc(
                  title: "Les plus populaires",
                  list: HorizontalOverviewList(list: data.popularMovies),
                  maxHeight: 300,
                  minHeight: 240,
                ),
                SliverBloc(
                  title: "Les mieux notés",
                  list: HorizontalOverviewList(
                    list: data.topRatedMovies,
                  ),
                  maxHeight: 300,
                  minHeight: 240,
                ),
                SliverBloc(
                  title: "Par genre",
                  icon: Icons.chevron_right,
                  list: HorizontalGenreList(
                    list: data.genresMovie,
                  ),
                  maxHeight: 100,
                  minHeight: 100,
                ),
                SliverDivider(title: "TV"),
                SliverBloc(
                  title: "Les plus populaires",
                  list: HorizontalOverviewList(
                    list: data.popularTv,
                  ),
                  maxHeight: 300,
                  minHeight: 240,
                ),
                SliverBloc(
                  title: "Les mieux notés",
                  list: HorizontalOverviewList(
                    list: data.topRatedTv,
                  ),
                  maxHeight: 300,
                  minHeight: 240,
                ),
                SliverBloc(
                  title: "Par genre",
                  icon: Icons.chevron_right,
                  list: HorizontalGenreList(
                    list: data.genresTv,
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

  Future<DataDiscoverView> loadData() async {
    return DataDiscoverView(
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
