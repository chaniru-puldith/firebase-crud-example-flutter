import 'package:flutter/material.dart';

class GradientIcon extends StatelessWidget {
  const GradientIcon({
    super.key,
    required this.icon,
  });

  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) => const RadialGradient(
        center: Alignment.topCenter,
        stops: [.5, 1],
        colors: [
          Colors.blue,
          Colors.purple,
        ],
      ).createShader(bounds),
      child: icon,
    );
  }
}
