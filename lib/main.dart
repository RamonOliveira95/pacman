import 'package:pacman_game/game_controller.dart';
import 'package:pacman_game/player/pac_man.dart';
import 'package:pacman_game/map/food.dart';
import 'ghosts/orange/ghost_orange.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:bonfire/bonfire.dart';
import 'ghosts/pink/ghost_pinky.dart';
import 'ghosts/blue/ghost_blue.dart';
import '/ghosts/red/ghost_red.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PacMan',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const MyHomePage(stage: 1,),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final int stage;
  const MyHomePage({Key? key, required this.stage}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BonfireTiledWidget(
      joystick: Joystick(
        keyboardConfig: KeyboardConfig(
          enable:
              true, // Use to enable ou disable keyboard events (default is true)
          acceptedKeys: [
            // You can pass specific Keys accepted. If null accept all keys
            LogicalKeyboardKey.space,
          ],
          keyboardDirectionalType: KeyboardDirectionalType
              .arrows // Type of the directional (arrows or wasd)
        ),
      ), // required
      map: TiledWorldMap(
        //Chamar o mapa criado no Tiled
        'map/mapa.json',
        objectsBuilder: {
          'Comida':(properties) => Food(properties.position),
        },
        //forçar o tamanho do mapa no game
        forceTileSize: const Size(32,32),
      ),
      player: PacMan(
        Vector2(15 * 16, 30 * 16),
      ),
      interface: GameInterface(
        
      ) ,
      cameraConfig: CameraConfig(
        moveOnlyMapArea: true,
      ),
      components: [
        //Vai retornar se morreu e quer começar novamente
        MyGameController(widget.stage),
        //posição dos fantasmas
        OrangeGhost(Vector2(16 * 16, 24 * 10)),
        PinkyGhost(Vector2(12 * 16, 30 * 10)),
        RedGhost(Vector2(12 * 16, 24 * 10)),
        BlueGhost(Vector2(16 * 16, 30 * 10)),
      ],
      showCollisionArea: false,
    );
  }
}