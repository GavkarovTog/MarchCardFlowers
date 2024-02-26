import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum Flower {
  redCartoon,
  blueStrange,
  pinkMorning,
  yellowSun,
  greenFrog,
  redSunrise
}

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

  Widget _createFlower(
      {required Flower type,
      required double beginScale,
      required double endScale,
      required AnimationController turns,
      required AnimationController scale,
      double top = 0,
      double left = 0}) {
    if (top > 1 || top < 0 || left < 0 || left > 1) {
      throw UnsupportedError(
          "top, left parameters can only take value in [0, 1] interval");
    }

    double screenWidth = MediaQuery.of(context).size.width;

    int flowerNumber = 0;
    switch (type) {
      case Flower.redCartoon:
        flowerNumber = 1;
        break;

      case Flower.blueStrange:
        flowerNumber = 2;
        break;

      case Flower.pinkMorning:
        flowerNumber = 3;
        break;

      case Flower.yellowSun:
        flowerNumber = 4;
        break;

      case Flower.greenFrog:
        flowerNumber = 5;
        break;

      case Flower.redSunrise:
        flowerNumber = 6;
        break;
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Positioned(
        top: constraints.maxHeight * top,
        left: constraints.maxWidth * left,
        child: ScaleTransition(
          scale: _gradientController
              .drive(Tween(begin: beginScale, end: endScale)),
          child: RotationTransition(
            turns: _reverseFlowerRotationController,
            child: Image.asset(
              "assets/images/flower_${(flowerNumber < 10 ? '0' : '') + flowerNumber.toString()}.png",
              width: screenWidth * 0.5,
              height: screenWidth * 0.5,
            ),
          ),
        ),
      );
    });
  }

  AnimationController _initController(Duration duration, TickerProvider ticker,
  {
    bool inReverse = false,
    bool toRepeat = false,
    bool loopBack = false
  }) {
    if (loopBack && toRepeat) {
      // TODO:
      throw UnsupportedError("Animation can't loop back and repeat simultaneously.");
    }

    AnimationController _controller = AnimationController(duration: duration, vsync: ticker);

    _controller.addStatusListener((status) {
      if (loopBack) {
        if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }

        else if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
      } else if (toRepeat) {
        if (status == AnimationStatus.completed) {
          _controller.forward();
        }

        if (status == AnimationStatus.dismissed) {
          _controller.reverse(from: 1.0);
        }
      }

    });

    if (inReverse) {
      _controller.reverse(from: 1.0);
    } else {
      _controller.forward();
    }

    return _controller;
  }

  @override
  void initState() {
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

    _tmpReverse = _initController(const Duration(seconds: 4), this, inReverse: true, toRepeat: true);

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

    _stackItems = [
      _createFlower(
        top: 0.5,
        left: 0.5,
        type: Flower.redCartoon,
        beginScale: 0.5,
        endScale: 0.5,
        turns: _reverseFlowerRotationController,
        scale: _gradientController,
      ),

      _createFlower(
        top: 0.2,
        left: 0.5,
        type: Flower.redCartoon,
        beginScale: 0.5,
        endScale: 0.5,
        turns: _tmpReverse,
        scale: _gradientController,
      ),
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
