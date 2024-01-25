import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'game_screen.dart';

Future<void> main() async {
  // final game = FlameGame();
  // runApp(GameWidget(game: game));

  WidgetsFlutterBinding.ensureInitialized();

  // await Flame.device.fullScreen();
  // image load
  await Flame.images.loadAll([
    "background_image.jpg",
    "enemy.png",
    "player.png",
    "Backgrounds.png",
    "Background_Grid.png",
    "Players.png",
    "Bullets.png",
    "Boom.png",
    "Items.png",
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SomeOneGameApp(),
    );
  }
}

class SomeOneGameApp extends StatelessWidget {
  const SomeOneGameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MyGamePage(),
    );
  }
}


