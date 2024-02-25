import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  List<Widget> _stackItems = [];

  @override
  void initState() {
    _gradientController =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);

    _gradientController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        _gradientController.forward();
      } else if (status == AnimationStatus.completed) {
        _gradientController.reverse();
      }
    });

    var animation = CurvedAnimation(
        parent: _gradientController, curve: Curves.easeInOutQuad);
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
      Align(
        alignment: Alignment.topLeft,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 480,
              left: 225,
              child: ScaleTransition(
                scale: _gradientController.drive(Tween(begin: 0.5, end: 0.5)),
                child: RotationTransition(
                  turns: _reverseFlowerRotationController,
                  child: Image.asset(
                    "assets/images/flower_04.png",
                    width: screenWidth * 0.5,
                    height: screenWidth * 0.5,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 480,
              right: 55,
              child: ScaleTransition(
                scale: _gradientController.drive(Tween(begin: 0.4, end: 0.3)),
                child: RotationTransition(
                  turns: _fasterFlowerRotationController,
                  child: Image.asset(
                    "assets/images/flower_03.png",
                    width: screenWidth * 0.5,
                    height: screenWidth * 0.5,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 630,
              left: 230,
              child: ScaleTransition(
                scale: _gradientController.drive(Tween(begin: 0.3, end: 0.5)),
                child: RotationTransition(
                  turns: _mediumFlowerRotationController,
                  child: Image.asset(
                    "assets/images/flower_01.png",
                    width: screenWidth * 0.5,
                    height: screenWidth * 0.5,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 150,
              top: 150,
              child: ScaleTransition(
                scale: _gradientController.drive(Tween(begin: 0.5, end: 0.5)),
                child: RotationTransition(
                  turns: _reverseFlowerRotationController,
                  child: Image.asset(
                    "assets/images/flower_04.png",
                    width: screenWidth * 0.5,
                    height: screenWidth * 0.5,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 83,
              top: 70,
              child: ScaleTransition(
                scale: _gradientController.drive(Tween(begin: 0.1, end: 0.2)),
                child: RotationTransition(
                  turns: _mediumFlowerRotationController,
                  child: Image.asset(
                    "assets/images/flower_05.png",
                    width: screenWidth * 0.5,
                    height: screenWidth * 0.5,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 83,
              top: 40,
              child: ScaleTransition(
                scale: _gradientController.drive(Tween(begin: 0.1, end: 0.2)),
                child: RotationTransition(
                  turns: _mediumFlowerRotationController,
                  child: Image.asset(
                    "assets/images/flower_04.png",
                    width: screenWidth * 0.5,
                    height: screenWidth * 0.5,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 90,
              top: 105,
              child: ScaleTransition(
                scale: _gradientController.drive(Tween(begin: 0.2, end: 0.3)),
                child: RotationTransition(
                  turns: _mediumFlowerRotationController,
                  child: Image.asset(
                    "assets/images/flower_01.png",
                    width: screenWidth * 0.5,
                    height: screenWidth * 0.5,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 40,
              top: 85,
              child: ScaleTransition(
                scale: _gradientController.drive(Tween(begin: 0.3, end: 0.3)),
                child: RotationTransition(
                  turns: _mediumFlowerRotationController,
                  child: Image.asset(
                    "assets/images/flower_02.png",
                    width: screenWidth * 0.5,
                    height: screenWidth * 0.5,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 95,
              child: ScaleTransition(
                scale: _gradientController.drive(Tween(begin: 0.2, end: 0.2)),
                child: RotationTransition(
                  turns: _mediumFlowerRotationController,
                  child: Image.asset(
                    "assets/images/flower_05.png",
                    width: screenWidth * 0.5,
                    height: screenWidth * 0.5,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 245,
              top: 100,
              child: ScaleTransition(
                scale: _gradientController.drive(Tween(begin: 0.4, end: 0.5)),
                child: RotationTransition(
                  turns: _reverseFlowerRotationController,
                  child: Image.asset(
                    "assets/images/flower_05.png",
                    width: screenWidth * 0.5,
                    height: screenWidth * 0.5,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 220,
              top: 0,
              child: ScaleTransition(
                scale: _gradientController.drive(Tween(begin: 0.6, end: 0.65)),
                child: RotationTransition(
                  turns: _reverseFlowerRotationController,
                  child: Image.asset(
                    "assets/images/flower_06.png",
                    width: screenWidth * 0.5,
                    height: screenWidth * 0.5,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 55,
              top: 124,
              child: ScaleTransition(
                scale: _gradientController.drive(Tween(begin: 0.4, end: 0.5)),
                child: RotationTransition(
                  turns: _fasterFlowerRotationController,
                  child: Image.asset(
                    "assets/images/flower_04.png",
                    width: screenWidth * 0.5,
                    height: screenWidth * 0.5,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 140,
              bottom: 26,
              child: ScaleTransition(
                scale: _gradientController.drive(Tween(begin: 0.6, end: 0.8)),
                child: RotationTransition(
                  turns: _reverseFlowerRotationController,
                  child: Image.asset(
                    "assets/images/flower_04.png",
                    width: screenWidth * 0.5,
                    height: screenWidth * 0.5,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 153,
              top: 70,
              child: ScaleTransition(
                scale: _gradientController.drive(Tween(begin: 0.6, end: 0.8)),
                child: RotationTransition(
                  turns: _mediumFlowerRotationController,
                  child: Image.asset(
                    "assets/images/flower_02.png",
                    width: screenWidth * 0.5,
                    height: screenWidth * 0.5,
                  ),
                ),
              ),
            ),

            Positioned(
              left: 45,
              top: 150,
              child: ScaleTransition(
                scale: _gradientController.drive(Tween(begin: 0.8, end: 0.6)),
                child: RotationTransition(
                  turns: _reverseFlowerRotationController,
                  child: Image.asset(
                    "assets/images/flower_03.png",
                    width: screenWidth * 0.5,
                    height: screenWidth * 0.5,
                  ),
                ),
              ),
            ),
            ScaleTransition(
              scale: _gradientController.drive(Tween(begin: 0.9, end: 1)),
              child: RotationTransition(
                turns: _mainFlowerRotationController,
                child: Image.asset(
                  "assets/images/flower_01.png",
                  width: screenWidth * 0.5,
                  height: screenWidth * 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
//       Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const SizedBox(height: 200),
//             const Text("8 марта",
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 128,
//                     fontFamily: "Christmass",
//                     shadows: [
//                       Shadow(
//                           blurRadius: 20,
//                           color: Colors.greenAccent
//                       )
//                     ]
//                 )),
//
//             const Text(
//               """
// Пусть весна подарит счастье,
// Настроение и успех.
// Пусть обходят вас ненастья,
// И звучит почаще смех!
//
// Наслаждайтесь, улыбайтесь.
// Оптимизма и добра.
// С праздником 8 Марта!
// Вы прекрасны, как всегда!
//                 """,
//               style: TextStyle(
//                   color: Colors.yellowAccent,
//                   fontSize: 20,
//                   fontFamily: "Sensei"
//               ),
//             )
//           ],
//         ),
//       ),
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
                value: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  // statusBarColor: _gradientController.drive(
                  //   ColorTween(begin: firstColor, end: secondColor)
                  // ).value!,
                ),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                        firstColor,
                        secondColor
                        // Color.fromRGBO(167, 255, 164 + brightAddition, 1),
                        // Color.fromRGBO(145, 255, 119 + brightAddition, 1),
                      ])),
                  child: Stack(
                    children: [
                      Stack(children: _stackItems),
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 200),
                            Text("8 марта",
                                style: TextStyle(
                                    color: _gradientController.drive(
                                      ColorTween(
                                        begin: Colors.white,
                                        end: Colors.orange.shade200
                                      )
                                    ).value,
                                    fontSize: 128,
                                    fontFamily: "Christmass",
                                    shadows: [
                                      Shadow(
                                          blurRadius: 20,
                                          color: Colors.white38
                                      )
                                    ]
                                )),

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
                                  fontFamily: "Sensei"
                              ),
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
