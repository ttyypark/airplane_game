import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import 'EnemyPlane.dart';

// enum PlayerDirection { go, left, right}

class PlayerPlane extends SpriteComponent with HasGameRef, DragCallbacks, CollisionCallbacks {
// class PlayerPlane extends SpriteComponent with HasGameRef, CollisionCallbacks {
  static const double playerSize = 60.0;
  final Function hitAction;

  late ShapeHitbox hitbox;
  // late final PlayerComponent _playerComponent;
  bool _isDragging = false;

  PlayerPlane({required super.position, required this.hitAction})
  // PlayerPlane({required Vector2 position, required this.hitAction})
      : super(size: Vector2.all(playerSize)){

    // _playerComponent = PlayerComponent<PlayerDirection>({
    // });
    // _playerComponent.current = PlayerDirection.go;
    // add(_playerComponent);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('player.png');
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
  void onDragUpdate(DragUpdateEvent event) {

    // 상단 범위 초과 금지
    if (position.y <= 100) {
      position.y += 10;
      return;
    }
    // 하단 범위 초과 금지
    if (position.y >= gameRef.size[1] - 50) {
      position.y -= 10;
      return;
    }

    // 좌측 범위 초과 금지
    if (position.x <= 0) {
      position.x += 10;
      return;
    }
    // 우측 범위 초과 금지
    if (position.x >= gameRef.size[0] - 50) {
      position.x -= 10;
      return;
    }
    // if (position.x >= gameRef.size[0] - 150) {
    //   position.x -= 10;
    //   return;
    // }

    // // 드래그 하지 않는 경우
    // if (event.localDelta.x == 0) {
    //   _playerComponent.current = PlayerDirection.go;
    // }
    // // 우측으로 드래그중인 경우
    // else if (event.localDelta.x > 0) {
    //   _playerComponent.current = PlayerDirection.right;
    // }
    // // 좌측으로 드래그중인 경우
    // else if (event.localDelta.x < 0) {
    //   _playerComponent.current = PlayerDirection.left;
    // }
    // 드래그 방향에 따라 이동
    position.x += event.localDelta.x;
    position.y += event.localDelta.y;

    // super.onDragUpdate(event);
    // position.x = (position.x + event.localDelta.x)
    // .clamp(width / 2, game.width - width / 2);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    if (!_isDragging) {
      return;
    }

    _isDragging = false;
    // _playerComponent.current = PlayerDirection.go;
  }



  // void moveBy(double dx) {
  //   add(MoveToEffect(
  //     Vector2(
  //       (position.x + dx).clamp(width / 2, game.width - width / 2),
  //       position.y,
  //     ),
  //     EffectController(duration: 0.1),
  //   ));
  // }

  // CollisionCallbacks Mixin 사용시 @override 가능, 충돌 발생시 메서드
  @override
  Future<void> onCollision(Set<Vector2> intersectionPoints, PositionComponent other) async {
    super.onCollision(intersectionPoints, other);
    if (other is ScreenHitbox) {
      // 내 비행기의 위치가 게임판의 x값보다 크면?
      // 그대로 x값 0에 고정
      print("******* " + position.toString());
      if (position.x < size.x) {
        position = Vector2(0, position.y);
        // 그게 아니면? 겹치지 않는 맨 끝 위치에 고정
      } else {
        position = Vector2(game.size.x - size.x, position.y);
      }
    } else if (other is EnemyPlane) {
      // other의 타입을 지정해서 충돌이 일어나는 컴포넌트별로 분기할 수 있다.
      // print("****** enemy plane * " + position.toString());

      hitAction(); //외부로 받아온 매개변수
    }
  }
}

// class PlayerComponent<T> extends SpriteAnimationGroupComponent<T> {
//   PlayerComponent(Map<T, SpriteAnimation> playerAnimationMap)
//       : super(size: Vector2(40, 40), animations: playerAnimationMap);
//
//   @override
//   void update(double dt) {
//     super.update(dt);
//   }
//
//   void playerUpdate(PlayerDirection playerDirection) {
//     current = playerDirection as T?;
//   }
// }
