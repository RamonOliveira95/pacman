import 'package:bonfire/base/game_component.dart';
import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:pacman_game/main.dart';


class MyGameController extends GameComponent {
  bool fim = false;
  final int? stage;
  //Foi criado o stage para mostrar que tem um mapa e quando terminar voltar para ele quando clicado na opção.
  MyGameController(this.stage);

  @override
  void update(double dt) {
    if (checkInterval('Fim de jogo', 500, dt)) {
      if (gameRef.player?.isDead == true && !fim) {
        fim = true;
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: const Text("Você Morreu",
              textAlign: TextAlign.center),
              actions: [
                TextButton(
                  onPressed: () {
                    _goStage(stage!);
                  },
                  child: const Text("Tentar novamente",
                  textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue)),
                )
              ],
            );
          },
        );
      }
    }

    if (checkInterval('Fim de jogo', 500, dt)) {
      //Quando identifcar que tem exatamente 4 inimigos, irá ganhar o jogo
      if (gameRef.livingEnemies().length == 4 && !fim) {
        fim = true;
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: const Text("Você Ganhou"),
              actions: [
                TextButton(
                  onPressed: () {
                    _goStage(stage!);
                  },
                  child: const Text("Jogar Novamente",
                      style: TextStyle(color: Colors.blue)),
                )
              ],
            );
          },
        );
      }
    }

    super.update(dt);
  }

  void _goStage(int newStage) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) {
        return MyHomePage(stage: newStage);
      }),
      (route) => false,
    );
  }
}
