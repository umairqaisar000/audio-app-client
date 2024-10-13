import 'dart:math' as math;

import 'package:flutter/material.dart';

class AudioUserWidget extends StatelessWidget {
  AudioUserWidget({super.key, required this.userName});
  String userName;

  @override 
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border:
                Border.all(color: Theme.of(context).dividerColor, width: 2)),
        alignment: Alignment.center,
        child: LayoutBuilder(
          builder: (ctx, constraints) => Text(
            userName,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize:
                    math.min(constraints.maxHeight, constraints.maxWidth) *
                        0.3),
          ),
        ),
      );
}
