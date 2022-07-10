import 'package:flutter/material.dart';
import 'package:free_games_app/models/all_games_model.dart';
import 'package:free_games_app/models/game_model.dart';
import 'package:free_games_app/providers/free_games_provider.dart';
import 'package:free_games_app/widgets/app_bar_widget.dart';
import 'package:free_games_app/widgets/card_image_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class GameDetailScreen extends StatelessWidget {
  const GameDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final game = ModalRoute.of(context)!.settings.arguments as AllGamesResponse;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 56),
        child: AppBarWidget(text: game.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Hero(
                tag: game,
                child: Image.network(
                  game.thumbnail,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.indigo, width: 1.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: MaterialButton(
                onPressed: () async {
                  if (!await launchUrl(Uri.parse(game.gameUrl))) {
                    throw 'Could not launch ${game.gameUrl}';
                  }
                },
                child: const Text('Game URL'),
              ),
            ),
            FutureBuilder(
              future: FreeGamesProvider().getGame(game.id),
              builder: (context, AsyncSnapshot<Game> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.indigo),
                  );
                } else {
                  final game = snapshot.data;
                  return Container(
                    padding:
                        const EdgeInsets.only(top: 10, right: 20, left: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _CardDetail(
                              title: 'Genre:',
                              description: game?.genre,
                            ),
                            _CardDetail(
                              title: 'Platform:',
                              description: game?.platform,
                            ),
                            _CardDetail(
                              title: 'Publisher:',
                              description: game?.publisher,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Description:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              game!.description,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Screenshots:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            SizedBox(
                              height: 170,
                              width: double.infinity,
                              child: ListView.builder(
                                itemCount: game.screenshots.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return CardImageWidget(
                                    image: game.screenshots[index],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20)
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CardDetail extends StatelessWidget {
  final String? title;
  final String? description;
  const _CardDetail({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 80,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.indigo, width: 1.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title!, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(description!, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
