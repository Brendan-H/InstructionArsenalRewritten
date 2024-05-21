/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (star_difficulty.dart) Last Modified on 1/3/23, 4:58 PM
 *
 */

import 'package:flutter/material.dart';

class StarDifficulty extends StatelessWidget {
  final int difficulty;
  const StarDifficulty({Key? key, required this.difficulty}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color starColor = Colors.grey;
    if (difficulty == 1) {
      starColor = Colors.lightGreen;
    } else if (difficulty == 2) {
      starColor = Colors.yellow;
    } else if (difficulty == 3) {
      starColor = Colors.orange;
    } else if (difficulty == 4) {
      starColor = Colors.red;
    }
    return Row(
      children: List.generate(
        4,
            (index) => Visibility(
          visible: difficulty > index,
          child: Icon(
            Icons.star,
            color: starColor,
          ),
        ),
      ),
    );
  }
}