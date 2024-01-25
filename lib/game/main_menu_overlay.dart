import 'package:airplane_game/game_screen.dart';
import 'package:airplane_game/game/MyGame.dart';
import 'package:airplane_game/managers/game_manager.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class MainMenuOverlay extends StatefulWidget {
  final Game game;
  const MainMenuOverlay(this.game, {super.key});

  @override
  State<MainMenuOverlay> createState() => _MainMenuOverlayState();
}

class _MainMenuOverlayState extends State<MainMenuOverlay> {
  @override
  Widget build(BuildContext context) {
    MyGame game = widget.game as MyGame;

    return LayoutBuilder(builder: (_, constraints) {
      late String buttonStr;
      late double backOpacity;
      if (game.gameManager.currentState == GameState.intro) {
        backOpacity = 1;
        buttonStr = '시작하기';
      } else if (game.gameManager.currentState == GameState.pause) {
        backOpacity = 0.8;
        buttonStr = '계속하기';
      }

        return Material(
          color: Colors.transparent,
          child: Opacity(
            opacity: backOpacity,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                color: Theme.of(context).colorScheme.background,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          '2D 슈팅게임',
                          style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 100,),
                        ElevatedButton(
                            onPressed: () {
                              if (game.gameManager.currentState == GameState.intro) {
                                game.startGame();
                              } else if (game.gameManager.currentState == GameState.pause){
                                game.pauseAndRsumeGame();
                              }
                            },
                            child: Text(
                              buttonStr,
                              style: TextStyle(fontSize: 20),
                            )
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

      );
    });
  }
}
