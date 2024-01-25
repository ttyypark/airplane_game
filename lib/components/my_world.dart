import 'package:airplane_game/MyBackground.dart';
import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';

import '../game/MyGame.dart';
// import 'background.dart';

class MyWorld extends Component with HasGameRef<MyGame> {
  late MyBackground _background;

  @override
  Future<void> onLoad() async {
    var backgroundSprite = gameRef.images.fromCache('background_image.jpg');
    // var backgroundSprite = gameRef.images.fromCache('background_image.jpg');
    // _background = Background(backgroundSprites, Vector2(0, -gameRef.size.y));

    // _background = MyBackground(backgroundSprite, Vector2(0, 0));
    _background = MyBackground();

    // _background = MyBackground();
    add(_background);
  }

  @override
  void update(double dt) {
    //
  }
}