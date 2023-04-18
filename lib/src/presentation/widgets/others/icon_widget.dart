import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  const IconWidget(
    this.icon, {
    Key? key,
    this.size = 32,
    this.color,
    this.gradient,
  }) : super(key: key);

  final IconData icon;
  final double size;
  final Color? color;
  final List<Color>? gradient;

  @override
  Widget build(BuildContext context) {
    final data = Icon(
      icon,
      size: size,
      color: color ?? Colors.white,
    );
    return gradient != null
        ? ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.2, 0.5, 1.0],
                colors: gradient!,
              ).createShader(rect);
            },
            child: data,
          )
        : data;
  }
}
