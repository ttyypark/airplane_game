// import 'package:flutter/material.dart';

import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';

class MyBackground extends SpriteComponent with HasGameRef {
// class AirplaneGameBg extends SpriteComponent with HasGameRef {
  late final BackgroundComponent _background01;
  double get background01X => _background01.x;
  double get background01Y => _background01.y;

  // MyBackground(Image spriteImg, Vector2 postion) {
  //   _background01 = BackgroundComponent(
  //       // spriteImg, Vector2(0, 0), size, postion);
  //       spriteImg, Vector2(0, 0), Vector2(gameRef.size.x, gameRef.size.y), postion);
  //
  //   add(_background01);
  // }

  @override
  void update(double dt) {
    super.update(dt);
  }

  void setPositionBGImg01(double x, double y) {
    _background01.position.x = x;
    _background01.position.y = y;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('background_image.jpg');
    size = Vector2(gameRef.size.x, gameRef.size.y);
  }
}

class BackgroundComponent extends SpriteComponent {
  BackgroundComponent(Image backgroundImag, Vector2 srcPosition,
      Vector2 srcSize, Vector2 postion)
      : super.fromImage(backgroundImag,
      srcPosition: srcPosition,
      srcSize: srcSize,
      position: postion,
  );
      // // 배경 이미지 사이즈를 전체 화면 세로 사이즈의 두배로 설정
      // size: Vector2(
      //     Singleton().screenSize!.x, Singleton().screenSize!.y * 2));

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }
}