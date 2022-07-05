import 'package:flutter/material.dart';
import 'package:free_games_app/models/all_games_model.dart';
import 'package:free_games_app/providers/free_games_provider.dart';
import 'package:free_games_app/widgets/app_bar_widget.dart';
import 'package:free_games_app/widgets/card_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gamesProvider = Provider.of<FreeGamesProvider>(context);

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 56),
        child: AppBarWidget(text: 'FREE GAMES'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _ItemsCardList(title: 'All Free-To-Play Games'),
            _DropDownItem(gamesProvider: gamesProvider),
            _ItemsCardList(
              title: 'Best ${gamesProvider.selectedCategory} Games',
              category: gamesProvider.selectedCategory,
            ),
            const _ItemsCardList(
              title: 'Best Pixel Games',
              category: 'pixel',
            ),
            const _ItemsCardList(
              title: 'Best Shooter Games',
              category: 'shooter',
            ),
            const _ItemsCardList(
              title: 'Best MMORPG Games',
              category: 'mmorpg',
            ),
          ],
        ),
      ),
    );
  }
}

class _DropDownItem extends StatelessWidget {
  const _DropDownItem({
    Key? key,
    required this.gamesProvider,
  }) : super(key: key);

  final FreeGamesProvider gamesProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 10),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Select a category:'),
          const Expanded(child: SizedBox()),
          DropdownButton(
            value: gamesProvider.selectedCategory,
            items: gamesProvider.categories
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: gamesProvider.setSelectedCategory,
          ),
        ],
      ),
    );
  }
}

class _ItemsCardList extends StatelessWidget {
  final String title;
  final String? category;

  const _ItemsCardList({
    Key? key,
    required this.title,
    this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gamesProvider = Provider.of<FreeGamesProvider>(context);

    return FutureBuilder(
      future: gamesProvider.getAllGames(category),
      builder: (context, AsyncSnapshot<List<AllGamesResponse>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
              child: CircularProgressIndicator(color: Colors.indigo));
        } else {
          return _ItemCardListResult(title: title, snapshot: snapshot);
        }
      },
    );
  }
}

class _ItemCardListResult extends StatelessWidget {
  const _ItemCardListResult({
    Key? key,
    required this.title,
    required this.snapshot,
  }) : super(key: key);

  final String title;
  final AsyncSnapshot<List<AllGamesResponse>> snapshot;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: ListView.builder(
              itemCount: snapshot.data?.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CardWidget(game: snapshot.data![index]);
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                elevation:
                    MaterialStateProperty.resolveWith<double>((states) => 20),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (states) => Colors.black,
                ),
              ),
              child: const Text(
                'View all games',
                style: TextStyle(color: Colors.indigo),
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/list',
                  arguments: [snapshot.data, title],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
