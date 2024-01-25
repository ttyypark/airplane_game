import 'package:airplane_game/game/game_overlay.dart';
import 'package:airplane_game/game/main_menu_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import 'game/MyGame.dart';

class MyGamePage extends StatefulWidget {
  const MyGamePage({super.key});

  @override
  State<MyGamePage> createState() => _MyGamePageState();
}

class _MyGamePageState extends State<MyGamePage> {
// class _MyGamePageState extends State<MyGamePage> with SingleTickerProviderStateMixin {
  // AnimationController? _controller;
  // Alignment _dragAlignment = Alignment.center;
  // Animation<Alignment>? _animation;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _controller = AnimationController(vsync: this);
  //
  //   _controller!.addListener(() {
  //     setState(() {
  //       _dragAlignment = _animation!.value;
  //     });
  //   });
  // }
  //
  // @override
  // void dispose() {
  //   _controller!.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Airplane Game"),
      ),
      body: Center(
        // child: GestureDetector(
        //   onPanDown: (details) {
        //     _controller!.stop();
        //   },
        //   onPanUpdate: (details) {
        //     setState(() {
        //       _dragAlignment += Alignment(
        //         details.delta.dx / (size.width / 2),
        //         details.delta.dy / (size.height / 2),
        //       );
        //     });
        //   },
        //   // onPanEnd: (details) {
        //   //   _runAnimation(details.velocity.pixelsPerSecond, size);
        //   // },

        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: GameWidget(
            game: MyGame(), // 이부분에 게임 인스턴스를 넣어준다.
            // Map<String, Widget Function> 타입의 overlayBuilderMap을 추가한다.
            // String으로 Overlay 이름을 정하고 위젯을 만들어두면 Game내에서 overlay.add 가능
            overlayBuilderMap: {
              // context와 game을 모두 참조할 수 있다.
              // game의 클래스 타입을 제대로 명시해주지 않으면 내부메서드 사용이 어렵다.
              'leftRightButton': (BuildContext context, MyGame game) {
                return Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(onPressed: () {
                          game.flyLeft();
                        }, child: Text("<")),
                        ElevatedButton(onPressed: (){
                          game.flyRight();
                        }, child: Text(">")),
                      ],
                    ),
                  ),
                );
              },
              'gameOverlay': (BuildContext context, MyGame game) => GameOverlay(game),
              'mainMenuOverlay': (BuildContext context, MyGame game) => MainMenuOverlay(game),
            },
          ),
        ),
      ),
    );
  }
}