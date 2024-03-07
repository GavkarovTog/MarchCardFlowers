import 'package:flutter/material.dart';

import 'particle_painter.dart';
import 'particles_system.dart';

class AnimatedParticlesBackground extends AnimatedWidget {
  final AnimationController controller;
  late final ParticleManager particleManager;


  AnimatedParticlesBackground({super.key, required this.controller}) : super(listenable: controller) {
    particleManager = ParticleManager(
        controller: controller,
        colors: [
          Colors.yellow,
          Colors.orange,
          Colors.amber,
        ],
        opacityRange: PInterval(begin: 0.1, end: 0.7),
        sizeRange: PInterval(begin: 5, end: 10),
        velocityRange: PInterval(begin: 0.01, end: 0.02),
        fading: true
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        if (! particleManager.inited) {
          const baseDeviceArea = 289618.5123966942;
          // pixel 3 -> 500
          // another - x

          final countOfParticles = 500 * constraints.maxWidth * constraints.maxHeight
              ~/ baseDeviceArea;

          particleManager.initParticles(countOfParticles);
        } else {
          particleManager.update();
        }

        return Container(
          alignment: Alignment.center,
          color: Colors.transparent,
          child: CustomPaint(
            size: Size.infinite,
            foregroundPainter: ParticlePainter(
                particleManager.particles),
          ),);
      },
    );
  }
}
