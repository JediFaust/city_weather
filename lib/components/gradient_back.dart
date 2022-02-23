import 'package:flutter/material.dart';

var gradientDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: const [0, 0.5, 1],
    colors: [
      Colors.blue[300] as Color,
      Colors.blue[300] as Color,
      Colors.blue[200] as Color,
    ],
  ),
);
