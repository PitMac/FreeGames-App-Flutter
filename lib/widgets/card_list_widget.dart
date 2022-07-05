import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:free_games_app/models/all_games_model.dart';

class CardListWidget extends StatelessWidget {
  final AllGamesResponse game;

  const CardListWidget({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/game', arguments: game);
      },
      child: Hero(
        tag: game,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          height: 70,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.indigo, width: 1.5),
            borderRadius: BorderRadius.circular(10),
            color: Colors.indigo,
            image: DecorationImage(
              image: NetworkImage(game.thumbnail),
              fit: BoxFit.cover,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                alignment: Alignment.center,
                color: Colors.grey.withOpacity(0.1),
                child: Material(
                  type: MaterialType.transparency,
                  child: Text(
                    game.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: Colors.indigo,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
