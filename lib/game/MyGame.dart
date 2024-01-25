import 'dart:async' as ASYNC;
import 'dart:ffi';
import 'dart:math';

import 'package:airplane_game/managers/game_manager.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

import '../MyBackground.dart';
import '../components/EnemyPlane.dart';
import '../components/PlayerPlane.dart';
import '../components/my_world.dart';

late MyWorld world;

class MyGame extends FlameGame with TapCallbacks, HasCollisionDetection {
  // final YourBackground _background = YourBackground();
  late MyWorld _world;
  late PlayerPlane _playerPlane;
  final GameManager _gameManager = GameManager();

  late ASYNC.Timer? _enemyTimer;
  late ASYNC.Timer? _enemyTimer2;

  GameManager get gameManager => _gameManager;

  Null Function() hitAction = () {};

  // 게임 인스턴스가 생성될때 실행하는 함수, 대부분 여기에 내용을 배치한다.
  @override
  Future<void> onLoad() async {
    // final MyBackground _background = MyBackground();
    // world.add(_background);
    // await add(_background);wor

    _world = MyWorld();
    await add(_world);
    await add(_gameManager);


    _playerPlane = PlayerPlane(
        position: Vector2(size.x / 2 - 30, size.y - 100), hitAction: hitAction);
    await add(_playerPlane);
    // overlay.add를 하면 상위에 정의해둔 String을 Key로 오버레이를 불러온다.
    overlays.add("gameOverlay");
    // overlays.add("leftRightButton");

    // 타이머 한개는 1초마다, 한개는 1.5초마다 적 비행기 생성한다.
    // 타이머 시간은 임의로 수정하면 된다.
    _enemyTimer =
        ASYNC.Timer.periodic(const Duration(milliseconds: 1000), (timer) {
          add(addEnemy(2));
        });
    _enemyTimer2 =
        ASYNC.Timer.periodic(const Duration(milliseconds: 1500), (timer) {
          add(addEnemy(5));
        });
    super.onLoad();
  }

  EnemyPlane addEnemy(int speed) {
    // x축의 위치를 랜덤하게 만들어준다.
    // y축의 위치는 임의로 30으로 고정한다.
    int randomDx = Random().nextInt(13) + 1;
    return EnemyPlane(position: Vector2(randomDx * 30, 30), speed: speed);   // 적 비행기 속도?
  }


  // 업데이트 되는 매 프레임마다 실행되는 로직
  @override
  void update(double dt) async {
    super.update(dt);

    if (_gameManager.currentState == GameState.gameOver){
      return;
    }

    if (_gameManager.currentState == GameState.intro ||
        _gameManager.currentState == GameState.pause){
      overlays.add('mainMenuOverlay');
      return;
    }
  }



  void startGame() {
    // _initializeGameStart();
    _gameManager.changeState(GameState.playing);
    overlays.remove('mainMenuOverlay');
  }

  void pauseAndRsumeGame() {
    if (_gameManager.currentState == GameState.playing) {
      pauseEngine();
      overlays.add('mainMenuOverlay');
      _gameManager.changeState(GameState.pause);
    } else if (_gameManager.currentState == GameState.pause) {
      overlays.remove('mainMenuOverlay');
      resumeEngine();
      _gameManager.changeState(GameState.playing);
    }  }

  // 인스턴스가 해제될 떄 실행되는 로직
  @override
  void onRemove() {
    super.onRemove();
  }

  void flyLeft() {
    _playerPlane.position =
        Vector2(_playerPlane.position.x - 10, _playerPlane.position.y);
  }

  void flyRight() {
    _playerPlane.position =
        Vector2(_playerPlane.position.x + 10, _playerPlane.position.y);
  }



  // @override
  // void onCollision(Set<Vector2> points, PositionComponent other) {
  //   super.onCollision(points, other);
  //   // 스크린과 부딛히면?
  //   if (other is ScreenHitbox) {
  //     // 내 비행기의 위치가 게임판의 x값보다 크면?
  //     // 그대로 x값 0에 고정
  //     if (position.x < size.x) {
  //       position = Vector2(0, position.y);
  //       // 그게 아니면? 겹치지 않는 맨 끝 위치에 고정
  //     } else {
  //       position = Vector2(game.size.x - size.x, position.y);
  //     }
  //   }
  //   // ...생략
  // }

}
