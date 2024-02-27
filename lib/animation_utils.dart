import 'package:flutter/material.dart';

enum FlowerType {
  redCartoon,
  blueStrange,
  pinkMorning,
  yellowSun,
  greenFrog,
  redSunrise
}


AnimationController initController(Duration duration, TickerProvider ticker,
    {
      bool inReverse = false,
      bool toRepeat = false,
      bool loopBack = false
    }) {
  if (loopBack && toRepeat) {
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
      if (inReverse) {
        if (status == AnimationStatus.dismissed) {
          _controller.reverse(from: 1.0);
        }
      } else {
        if (status == AnimationStatus.completed) {
          _controller.forward();
        }
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

class Flower extends AnimatedWidget {
  final double size;
  final FlowerType type;
  final double beginScale;
  final double endScale;
  final AnimationController turns;
  final AnimationController scale;

  Flower({
    super.key,
      required this.size,
      required this.type,
      required this.beginScale,
      required this.endScale,
      required this.turns,
      required this.scale}) : super(listenable: Listenable.merge([turns, scale]));

  @override
  Widget build(BuildContext context) {
    int flowerNumber = 0;
    switch (type) {
      case FlowerType.redCartoon:
        flowerNumber = 1;
        break;

      case FlowerType.blueStrange:
        flowerNumber = 2;
        break;

      case FlowerType.pinkMorning:
        flowerNumber = 3;
        break;

      case FlowerType.yellowSun:
        flowerNumber = 4;
        break;

      case FlowerType.greenFrog:
        flowerNumber = 5;
        break;

      case FlowerType.redSunrise:
        flowerNumber = 6;
        break;
    }

    return ScaleTransition(
      scale: scale
          .drive(Tween(begin: beginScale, end: endScale)),
      child: RotationTransition(
        turns: turns,
        child: Image.asset(
          "assets/images/flower_${(flowerNumber < 10 ? '0' : '') + flowerNumber.toString()}.png",
          width: size,
          height: size,
        ),
      ),
    );
  }

}

class FlowerFactory {
  final double size;
  FlowerFactory(this.size);

  Widget createFlower({
    required FlowerType type,
    required double beginScale,
    required double endScale,
    required AnimationController turns,
    required AnimationController scale
  }) {
    return Flower(
      size: size,
      type: type,
      beginScale: beginScale,
      endScale: endScale,
      turns: turns,
      scale: scale,
    );
  }
}

// Widget createFlower(
//     {required FlowerType type,
//       required double beginScale,
//       required double endScale,
//       required AnimationController turns,
//       required AnimationController scale,
//       double top = 0,
//       double left = 0}) {
//   if (top > 1 || top < 0 || left < 0 || left > 1) {
//     throw UnsupportedError(
//         "top, left parameters can only take value in [0, 1] interval");
//   }
//
//   double screenWidth = MediaQuery.of(context).size.width;
//
//   int flowerNumber = 0;
//   switch (type) {
//     case FlowerType.redCartoon:
//       flowerNumber = 1;
//       break;
//
//     case FlowerType.blueStrange:
//       flowerNumber = 2;
//       break;
//
//     case FlowerType.pinkMorning:
//       flowerNumber = 3;
//       break;
//
//     case FlowerType.yellowSun:
//       flowerNumber = 4;
//       break;
//
//     case FlowerType.greenFrog:
//       flowerNumber = 5;
//       break;
//
//     case FlowerType.redSunrise:
//       flowerNumber = 6;
//       break;
//   }
//
//   return LayoutBuilder(builder: (context, constraints) {
//     return Positioned(
//       top: constraints.maxHeight * top,
//       left: constraints.maxWidth * left,
//       child: ScaleTransition(
//         scale: _gradientController
//             .drive(Tween(begin: beginScale, end: endScale)),
//         child: RotationTransition(
//           turns: _reverseFlowerRotationController,
//           child: Image.asset(
//             "assets/images/flower_${(flowerNumber < 10 ? '0' : '') + flowerNumber.toString()}.png",
//             width: screenWidth * 0.5,
//             height: screenWidth * 0.5,
//           ),
//         ),
//       ),
//     );
//   });
// }
//
