import 'package:cocktailr/src/models/enums/device_screen_type.dart';
import 'package:flutter/widgets.dart';

class SizingInformation {
  final DeviceScreenType deviceScreenType;
  final Size screenSize;
  final Size localWidgetSize;

  SizingInformation({
    this.deviceScreenType,
    this.screenSize,
    this.localWidgetSize,
  });
}
