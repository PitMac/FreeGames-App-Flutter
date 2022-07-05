import 'package:flutter/material.dart';
import 'package:free_games_app/models/game_model.dart';

class CardImageWidget extends StatelessWidget {
  final Screenshot? image;
  const CardImageWidget({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.indigo,
      ),
      margin: const EdgeInsets.only(right: 10),
      width: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          image!.image,
          fit: BoxFit.cover,
          width: 120,
        ),
      ),
    );
  }
}
