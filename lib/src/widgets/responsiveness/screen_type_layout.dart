import 'package:cocktailr/src/models/enums/device_screen_type.dart';
import 'package:cocktailr/src/widgets/responsiveness/responsive_builder.dart';
import 'package:flutter/material.dart';

class ScreenTypeLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ScreenTypeLayout({
    Key key,
    @required this.mobile,
    this.tablet,
    this.desktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInfo) {
      if (sizingInfo.deviceScreenType == DeviceScreenType.Desktop && desktop != null) {
        return desktop;
      }

      if (sizingInfo.deviceScreenType == DeviceScreenType.Tablet && tablet != null) {
        return tablet;
      }

      return mobile;
    });
  }
}
