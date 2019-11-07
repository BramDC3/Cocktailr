import 'package:cocktailr/src/models/enums/device_screen_type.dart';
import 'package:flutter/cupertino.dart';

DeviceScreenType getDeviceScreenType(MediaQueryData mediaQuery) {
  final double deviceWidth = mediaQuery.size.shortestSide;

  if (deviceWidth > 950) {
    return DeviceScreenType.Desktop;
  }

  if (deviceWidth > 600) {
    return DeviceScreenType.Tablet;
  }

  return DeviceScreenType.Mobile;
}
