import 'dart:async' as ASYNC;
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'PlayerPlane.dart';

// enum으로 비행기의 상태를 관리하자, 날고있는지 아니면 충돌했는지
enum EnemyPlaneState { flying, hit }

class EnemyPlane extends SpriteComponent with HasGameRef, CollisionCallbacks {
  static const double enemySize = 60.0;
  final int speed;

  EnemyPlane({required Vector2 position, required this.speed})
      : super(size: Vector2.all(enemySize), position: position);

  late ShapeHitbox hitbox;

  //초기 상태는 비행중으로
  EnemyPlaneState _state = EnemyPlaneState.flying;

  //getter를 써서 상태를 외부에서 변경 못하도록
  EnemyPlaneState get state => _state;
  late String planeType;
  late Sprite? _sprite;

  // 실행시 랜덤하게 Sprite를 결정해주자!
  String initRandomType() {
    int type = Random().nextInt(4);
    switch (type) {
      case 0:
        return 'enemy.png';
      case 1:
        return 'enemy.png';
      case 2:
        return 'enemy.png';
      case 3:
        return 'enemy.png';
      default:
        return 'enemy.png';
      // case 0:
      //   return 'airplane_game/enemies/enemy1-1.png';
      // case 1:
      //   return 'airplane_game/enemies/enemy2-1.png';
      // case 2:
      //   return 'airplane_game/enemies/enemy3-1.png';
      // case 3:
      //   return 'airplane_game/choppers/chopper2-2.png';
      // default:
      //   return 'airplane_game/enemies/enemy3-1.png';
    }
  }

  @override
  void onLoad() async {
    super.onLoad();
    // 실행시 랜덤하게 Sprite를 결정해주자!
    planeType = initRandomType();
    _sprite = await gameRef.loadSprite(planeType);
    // _sprite = await gameRef.loadSprite('enemy.png');
    sprite = _sprite;
    position = position;

    // 빨간색 원으로 잘 보이는 히트박스 만들어주기
    final Paint defaultPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke;
    hitbox = CircleHitbox()
      ..paint = defaultPaint // paint를 하지 않거나 선을 투명으로 하면 보이지 않음
      ..renderShape = true;
    add(hitbox);
  }

  @override
  void update(double dt) {
    // 외부에서 속도를 받아와서, flying(날고있는)상태면 계속 y값을 아래로 내리기    fly();
    if (_state == EnemyPlaneState.flying) {
      position = Vector2(position.x, position.y + speed);
    }
    super.update(dt);
  }

  // void fly(){
  //   // y값을 변경하며 매 프레임마다 아래로 날아가도록 로직을 구현하자
  // }

  // CollisionCallbacks Mixin 사용시 @override 가능, 충돌 발생시 메서드
  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    super.onCollision(points, other);
    if (other is ScreenHitbox) {
      // 게임 화면과 충돌했을 때 메서드 정의
      if (position.x > game.size.x) {
        if (position.x < size.x) {
          position = Vector2(0, position.y);
          return;
        } else {
          position = Vector2(game.size.x - size.x, position.y);
          return;
        }
      }
      // removeFromParent는 컴포넌트 클래스의 내부함수로, 이 컴포넌트를 해제한다.
      // 나랑 안 부딛히고 바닥에 부딛히면 없애버리자.
      if (position.y + size.y > game.size.y) {
        removeFromParent();
      }
    } else if (other is PlayerPlane) {
      // PlayerPlane 과 충돌이 일어 나는 로직.
      stopPlane();
    }
  }

  ASYNC.Timer? destroyTimer;

  void stopPlane() {
    _state = EnemyPlaneState.hit;
    destroy();
    Future.delayed(const Duration(seconds: 1), (() => removeFromParent()));
    // Timer클래스는 다 사용하면 항상 cancel()로 해제하자
    destroyTimer?.cancel();
  }

  // PlayerPlane과 충돌나면 깜빡거리는 점멸효과를 1초정도 준다.
  void destroy() async {
    _sprite = await gameRef.loadSprite(planeType);
    bool blink = false;
    sprite = null;
    destroyTimer =
        ASYNC.Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (blink == true) {
        sprite = null;
        blink = false;
      } else {
        sprite = _sprite;
        blink = true;
      }
    });
  }
}
