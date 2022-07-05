import 'package:flutter/material.dart';
import 'package:free_games_app/models/all_games_model.dart';

class CardWidget extends StatelessWidget {
  final AllGamesResponse game;
  const CardWidget({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/game', arguments: game);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.indigo, width: 1.5),
          borderRadius: BorderRadius.circular(10),
          color: Colors.indigo,
        ),
        margin: const EdgeInsets.only(right: 10),
        height: 50,
        width: 120,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Hero(
            tag: game,
            child: Image.network(
              game.thumbnail,
              fit: BoxFit.cover,
              height: 50,
            ),
          ),
        ),
      ),
    );
  }
}
