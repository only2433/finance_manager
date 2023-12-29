import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonPageRoute
{
  static Future<T?> toNamed<T>(String name) async
  {
    return await Get.to<T>(
      name,
      transition: Transition.leftToRight,
      duration: Duration(
        milliseconds: 350
      )
    );
  }

  static Future<T?> offNamed<T>(String name) async
  {
    return await Get.off(
      name,
      transition: Transition.rightToLeft,
      duration: Duration(
        milliseconds: 350
      )
    );
  }
}