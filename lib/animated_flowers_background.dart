import 'dart:math';

import 'package:flutter/material.dart';

import 'animation_utils.dart';

class AnimatedFlowersBackground extends StatefulWidget {
  const AnimatedFlowersBackground({super.key});

  @override
  State<AnimatedFlowersBackground> createState() => _AnimatedFlowersBackgroundState();
}

class _AnimatedFlowersBackgroundState extends State<AnimatedFlowersBackground> with TickerProviderStateMixin {
  late AnimationController _normalScaleController;
  late AnimationController _fasterScaleController;

  late AnimationController _nonRotatableFlower;
  late AnimationController _nonRotatableFlowerReverse;
  late AnimationController _mainFlowerRotationController;
  late AnimationController _fasterFlowerRotationController;
  late AnimationController _reverseFlowerRotationController;
  late AnimationController _mediumFlowerRotationController;

  @override
  void initState() {
    super.initState();

    AnimationControllerFactory factory = AnimationControllerFactory(this);

    _normalScaleController = factory.createController(const Duration(seconds: 5), loopBack: true,);
    _fasterScaleController = factory.createController(const Duration(seconds: 1), loopBack: true,);

    _nonRotatableFlower = factory.createController(const Duration(seconds: 1), loopBack: true, lowerBound: -0.05, upperBound: 0.05);
    _nonRotatableFlowerReverse = factory.createController(const Duration(seconds: 1), loopBack: true, inReverse: true, lowerBound: -0.05, upperBound: 0.05);
    _mainFlowerRotationController = factory.createController(const Duration(seconds: 6), toRepeat: true);
    _fasterFlowerRotationController = factory.createController(const Duration(seconds: 2), toRepeat: true);
    _reverseFlowerRotationController = factory.createController(const Duration(seconds: 4), inReverse: true, toRepeat: true);
    _mediumFlowerRotationController = factory.createController(const Duration(seconds: 4), toRepeat: true);

  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          FlowerManager manager = FlowerManager(
              constraints.maxWidth,
              constraints.maxHeight,
              min(constraints.maxWidth, constraints.maxHeight));

          return Stack(
              children: [
                manager.createFlower(
                    widthAxis: 0.17,
                    heightAxis: 1.0,
                    type: FlowerType.blueCrystal,
                    beginScale: 0.1,
                    endScale: 0.11,
                    turns: _mainFlowerRotationController,
                    scale: _normalScaleController),

                manager.createFlower(
                    widthAxis: 0,
                    heightAxis: 0.92,
                    type: FlowerType.pinkCookie,
                    beginScale: 0.1,
                    endScale: 0.11,
                    turns: _nonRotatableFlowerReverse,
                    scale: _normalScaleController),

                manager.createFlower(
                    widthAxis: 0,
                    heightAxis: 1,
                    type: FlowerType.orangeFive,
                    beginScale: 0.13,
                    endScale: 0.15,
                    turns: _reverseFlowerRotationController,
                    scale: _normalScaleController),

                manager.createFlower(
                    widthAxis: 1.0,
                    heightAxis: 1,
                    type: FlowerType.redRose,
                    beginScale: 0.1,
                    endScale: 0.1,
                    turns: _fasterFlowerRotationController,
                    scale: _normalScaleController),

                manager.createFlower(
                    widthAxis: 0.95,
                    heightAxis: 0.87,
                    type: FlowerType.pinkRegular,
                    beginScale: 0.1,
                    endScale: 0.1,
                    turns: _mainFlowerRotationController,
                    scale: _normalScaleController),

                manager.createFlower(
                    widthAxis: 0.9,
                    heightAxis: 0.98,
                    type: FlowerType.sunFlower,
                    beginScale: 0.15,
                    endScale: 0.25,
                    turns: _mediumFlowerRotationController,
                    scale: _normalScaleController),


                manager.createFlower(
                    widthAxis: 0.98,
                    heightAxis: 0.5,
                    type: FlowerType.orangeFive,
                    beginScale: 0.1,
                    endScale: 0.15,
                    turns: _fasterFlowerRotationController,
                    scale: _normalScaleController),

                manager.createFlower(
                    widthAxis: 0.05,
                    heightAxis: 0.6,
                    type: FlowerType.redRose,
                    beginScale: 0.1,
                    endScale: 0.15,
                    turns: _reverseFlowerRotationController,
                    scale: _fasterScaleController),

                manager.createFlower(
                    widthAxis: 0.98,
                    heightAxis: 0.08,
                    type: FlowerType.pinkCookie,
                    beginScale: 0.2,
                    endScale: 0.25,
                    turns: _nonRotatableFlower,
                    scale: _fasterScaleController),

                manager.createFlower(
                    widthAxis: 0.02,
                    heightAxis: 0.08,
                    type: FlowerType.pinkCookie,
                    beginScale: 0.2,
                    endScale: 0.25,
                    turns: _nonRotatableFlowerReverse,
                    scale: _fasterScaleController),

                manager.createFlower(
                    widthAxis: 0.5,
                    heightAxis: 0.00,
                    type: FlowerType.blueCrystal,
                    beginScale: 0.35,
                    endScale: 0.5,
                    turns: _mainFlowerRotationController,
                    scale: _normalScaleController),
              ]
          );
        }
    );
  }
}
