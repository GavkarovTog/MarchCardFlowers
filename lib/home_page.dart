import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:march_card/animated_flowers_background.dart';
import 'package:march_card/animation_utils.dart';
import 'dart:math';

import 'animated_particles_background.dart';

import 'package:audioplayers/audioplayers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _particleController;
  late AnimationController _gradientController;
  late AnimationController _textController;

  AudioPlayer player = AudioPlayer();
  // List<Widget> _stackItems = [];

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      player.pause();
    } else if (state == AppLifecycleState.resumed) {
      player.resume();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    AnimationControllerFactory factory = AnimationControllerFactory(this);

    _particleController = factory.createController(const Duration(seconds: 2), loopBack: true);
    _gradientController = factory.createController(const Duration(seconds: 5), loopBack: true,);
    _textController = factory.createController(const Duration(seconds: 6), loopBack: true);

    player.play(AssetSource("sounds/ambient.mp3"));
    player.onPlayerComplete.listen((event) {
      player.play(AssetSource("sounds/ambient.mp3"));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: AnnotatedRegion(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
          child: AnimatedLinearGradientContainer(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            tweens: [
              ColorTween(
                begin: Colors.lightGreenAccent.shade700,
                end: Colors.teal
              ),
              ColorTween(
                  begin: Colors.green,
                  end: const Color.fromRGBO(145, 255, 119, 1),
              )
            ],
            controller: _gradientController,

            child: Stack(
              children: [
                AnimatedParticlesBackground(controller: _particleController,),
                AnimatedFlowersBackground(),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // const SizedBox(height: 200),
                      AnimatedText(
                        "8 марта",
                        controller: _textController,
                        color: ConstantTween(Colors.white),
                        shadowColor: ColorTween(
                            begin: Colors.white,
                            end: Colors.red.shade100
                        ),
                        blurRadius: Tween<double>(
                          begin: 20,
                          end: 30
                        ),
                        fontSize: ConstantTween(128),
                      ),
                      const Text(
                        """
Пусть весна подарит счастье,
Настроение и успех.
Пусть обходят вас ненастья,
И звучит почаще смех!

Наслаждайтесь, улыбайтесь.
Оптимизма и добра.
С праздником 8 Марта!
Вы прекрасны, как всегда!
                        """,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 20,
                            fontFamily: "Sensei"),
                      ),
                    ],
                  ),
                ),
                ]
            )
          ),
        ),
      ),
    );
  }
}
