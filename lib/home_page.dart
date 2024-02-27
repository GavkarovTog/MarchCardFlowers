import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:march_card/animation_utils.dart';

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
  late AnimationController _tmpReverse;
  List<Widget> _stackItems = [];


  @override
  void initState() {
    _gradientController = initController(const Duration(seconds: 5), this, loopBack: true);
    _gradientController =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);

    _gradientController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        _gradientController.forward();
      }

      else if (status == AnimationStatus.completed) {
        _gradientController.reverse();
      }
    });

    _gradientController.forward();

    _mainFlowerRotationController =
        AnimationController(duration: const Duration(seconds: 6), vsync: this);
    _mainFlowerRotationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _mainFlowerRotationController.repeat();
      }
    });
    _mainFlowerRotationController.forward();

    _fasterFlowerRotationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _fasterFlowerRotationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _fasterFlowerRotationController.repeat();
      }
    });
    _fasterFlowerRotationController.forward();

    _reverseFlowerRotationController =
        AnimationController(duration: const Duration(seconds: 4), vsync: this);
    _reverseFlowerRotationController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        _reverseFlowerRotationController.reverse(from: 1.0);
      }
    });
    _reverseFlowerRotationController.reverse(from: 1.0);

    _reverseFlowerRotationController =
        AnimationController(duration: const Duration(seconds: 4), vsync: this);
    _reverseFlowerRotationController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        _reverseFlowerRotationController.reverse(from: 1.0);
      }
    });
    _reverseFlowerRotationController.reverse(from: 1.0);

    _tmpReverse = initController(const Duration(seconds: 4), this, inReverse: true, toRepeat: true);

    _mediumFlowerRotationController =
        AnimationController(duration: const Duration(seconds: 4), vsync: this);
    _mediumFlowerRotationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _mediumFlowerRotationController.repeat();
      }
    });
    _mediumFlowerRotationController.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    FlowerFactory factory = FlowerFactory(screenWidth);

    _stackItems = [
      factory.createFlower(
          type: FlowerType.redCartoon,
          beginScale: 0.7,
          endScale: 0.7,
          turns: _tmpReverse,
          scale: _gradientController),
    ];

    return Scaffold(
      body: SafeArea(
        top: false,
        child: AnimatedBuilder(
            animation: _gradientController,
            builder: (context, _) {
              Color firstColor = ColorTween(
                      begin: Colors.lightGreenAccent.shade700, end: Colors.teal)
                  .animate(_gradientController)
                  .value!;

              Color secondColor = ColorTween(
                      begin: Colors.green,
                      end: const Color.fromRGBO(145, 255, 119, 1))
                  .animate(_gradientController)
                  .value!;

              return AnnotatedRegion(
                value: const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                ),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [firstColor, secondColor])),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Stack(
                            clipBehavior: Clip.none, children: _stackItems),
                      ),
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // const SizedBox(height: 200),
                            Text("8 марта",
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
                            const SizedBox(
                              height: 40,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
