/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (widgets.dart) Last Modified on 12/22/22, 4:53 PM
 *
 */

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class BrendanButtonOptions {
  const BrendanButtonOptions({
    this.textStyle,
    this.elevation,
    this.height,
    this.width,
    this.padding,
    this.color,
    this.disabledColor,
    this.disabledTextColor,
    this.splashColor,
    this.iconSize,
    this.iconColor,
    this.iconPadding,
    this.borderRadius,
    this.borderSide,
  });

  final TextStyle? textStyle;
  final double? elevation;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? disabledColor;
  final Color? disabledTextColor;
  final Color? splashColor;
  final double? iconSize;
  final Color? iconColor;
  final EdgeInsetsGeometry? iconPadding;
  final double? borderRadius;
  final BorderSide? borderSide;
}

class BrendanButtonWidget extends StatelessWidget {
  const BrendanButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.iconData,
    required this.options,
  }) : super(key: key);

  final String text;
  final Widget? icon;
  final IconData? iconData;
  final VoidCallback onPressed;
  final BrendanButtonOptions options;

  @override
  Widget build(BuildContext context) {
    Widget textWidget = Text(
      text,
      style: options.textStyle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
    if (icon != null || iconData != null) {
      textWidget = Flexible(child: textWidget);
      return SizedBox(
        height: options.height,
        width: options.width,
        child: ElevatedButton.icon(
          icon: Padding(
            padding: options.iconPadding ?? EdgeInsets.zero,
            child: icon ??
                FaIcon(
                  iconData,
                  size: options.iconSize,
                  color: options.iconColor ?? options.textStyle!.color,
                ),
          ),
          label: textWidget,
          onPressed: onPressed,
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(options.elevation),
            padding: MaterialStateProperty.all(options.padding),
            backgroundColor: MaterialStateProperty.all(options.color),
            splashFactory: NoSplash.splashFactory,
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(options.borderRadius ?? 0),
                side: options.borderSide ?? BorderSide.none,
              ),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: options.height,
      width: options.width,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(options.padding),
          backgroundColor: MaterialStateProperty.all(options.color),
          elevation: MaterialStateProperty.all(options.elevation),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(options.borderRadius!),
              side: options.borderSide ?? BorderSide.none,
            ),
          ),
        ),
        onPressed: onPressed,
        child: textWidget,
      ),
    );
  }
}
