import 'package:flutter/material.dart';
import 'package:free_games_app/models/all_games_model.dart';
import 'package:free_games_app/providers/free_games_provider.dart';
import 'package:free_games_app/widgets/app_bar_widget.dart';
import 'package:free_games_app/widgets/card_list_widget.dart';
import 'package:provider/provider.dart';

class GamesListScreen extends StatefulWidget {
  const GamesListScreen({Key? key}) : super(key: key);

  @override
  State<GamesListScreen> createState() => _GamesListScreenState();
}

class _GamesListScreenState extends State<GamesListScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    List<AllGamesResponse> games = args[0];
    String title = args[1];
    final gameProvider = Provider.of<FreeGamesProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 56),
        child: AppBarWidget(text: title),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.indigo, width: 1.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search a game',
                  border: InputBorder.none,
                ),
                onChanged: (query) => gameProvider.searchResult(query, games),
              ),
            ),
            Expanded(
              child: ListView.builder(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: gameProvider.searchResults.isEmpty
                    ? games.length
                    : gameProvider.searchResults.length,
                itemBuilder: (context, index) {
                  return CardListWidget(
                    game: gameProvider.searchResults.isEmpty
                        ? games[index]
                        : gameProvider.searchResults[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
