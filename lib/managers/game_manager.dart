import 'package:airplane_game/game/MyGame.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

enum GameState { intro, playing, pause, gameOver }

class GameManager extends Component with HasGameRef<MyGame> {
  GameManager();

  GameState _state = GameState.intro;
  GameState get currentState => _state;

  void changeState(GameState state){
    _state = state;
  }

  // ValueNotifier<T> 클래스는 값 변경시 통보되고
  // ValueListenableBuilder로 구독해서 사용할 수 있다.
  // ScoreDisplay 위젯에서 사용된다.
  ValueNotifier<int> score = ValueNotifier(0);

  void increaseScore(int point) {
    score.value += point;
  }

  void reset() {
    score.value = 0;
  }
}