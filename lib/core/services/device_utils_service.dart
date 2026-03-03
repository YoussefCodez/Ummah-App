import 'package:flutter/material.dart';

abstract class DeviceUtilsService {
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600;
  }
}