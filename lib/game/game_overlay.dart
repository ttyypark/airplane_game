import 'package:airplane_game/game/MyGame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';


class GameOverlay extends StatefulWidget {
  final Game game;
  const GameOverlay(this.game, {super.key});

  @override
  State<GameOverlay> createState() => _GameOverlayState();
}

class _GameOverlayState extends State<GameOverlay > {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScoreDisplay(game: widget.game),
            ElevatedButton(
                onPressed: () => (widget.game as MyGame).pauseAndRsumeGame(),
                child: Icon(Icons.pause, size: 30,)
            )
          ],
        ),
      ),
    );
  }
}

class ScoreDisplay extends StatelessWidget {
  final Game game;

  const ScoreDisplay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: (game as MyGame).gameManager.score,
        builder: (context, value, child) {
          return Text('Score: $value',
          style: TextStyle(fontSize: 30, color: Colors.white)
          // style: Theme.of(context).textTheme.displaySmall,
          );
        }
    );
  }
}

