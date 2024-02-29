import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:march_card/animation_utils.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _gradientController;
  late AnimationController _mainFlowerRotationController;
  late AnimationController _fasterFlowerRotationController;
  late AnimationController _reverseFlowerRotationController;
  late AnimationController _mediumFlowerRotationController;
  // List<Widget> _stackItems = [];

  @override
  void initState() {
    AnimationControllerFactory factory = AnimationControllerFactory(this);

    _gradientController = factory.createController(const Duration(seconds: 5), loopBack: true,);
    _mainFlowerRotationController = factory.createController(const Duration(seconds: 6), toRepeat: true);
    _fasterFlowerRotationController = factory.createController(const Duration(seconds: 2), toRepeat: true);
    _reverseFlowerRotationController = factory.createController(const Duration(seconds: 4), inReverse: true, toRepeat: true);
    _mediumFlowerRotationController = factory.createController(const Duration(seconds: 4), toRepeat: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Widget animationTopBar = LayoutBuilder(
      builder: (context, constraints) {
        FlowerManager manager = FlowerManager(
            constraints.maxWidth,
            constraints.maxHeight,
            min(constraints.maxWidth, constraints.maxHeight));

        return Container(
          // color: Colors.blue,
          child: Stack(
              children: [

                // manager.createFlower(
                //     widthAxis: 0,
                //     heightAxis: 0.5,
                //     type: FlowerType.yellowSun,
                //     beginScale: 0.6,
                //     endScale: 0.6,
                //     turns: _reverseFlowerRotationController,
                //     scale: _gradientController),

                // Center big red flower
                manager.createFlower(
                  widthAxis: 0.5,
                  heightAxis: 0.5,
                  type: FlowerType.redCartoon,
                  beginScale: 1,
                  endScale: 1,
                  turns: _reverseFlowerRotationController,
                  scale: _gradientController),
              ]
          ),
        );
      }
    );

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
            child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: animationTopBar,
                      ),
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // const SizedBox(height: 200),
                            Center(
                              child: Text("8 марта",
                                  style: TextStyle(
                                      color: _gradientController
                                          .drive(ColorTween(
                                              begin: Colors.white,
                                              end: Colors.orange.shade200))
                                          .value,
                                      fontSize: 128,
                                      fontFamily: "Christmass",
                                      shadows: [
                                        const Shadow(
                                            blurRadius: 20, color: Colors.white38)
                                      ])),
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
                              style: TextStyle(
                                  color: Colors.yellowAccent,
                                  fontSize: 20,
                                  fontFamily: "Sensei"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
          ),
        ),
      ),
    );
  }
}
