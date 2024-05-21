/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (get_icon.dart) Last Modified on 1/3/23, 5:11 PM
 *
 */

import 'package:flutter/material.dart';

class GetIcon extends StatelessWidget {
  final String category;

  const GetIcon({required this.category});

  @override
  Widget build(BuildContext context) {
    IconData iconData = Icons.help;

    switch (category) {
      case "Automotive":
        iconData = Icons.directions_car;
        break;
      case "Technology":
        iconData = Icons.computer;
        break;
      case "Cooking":
        iconData = Icons.restaurant;
        break;
      case "Sports":
        iconData = Icons.sports;
        break;
      case "Home":
        iconData = Icons.home;
        break;
    }

    return Icon(iconData);
  }
}