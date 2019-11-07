import 'package:cocktailr/src/models/sizing_information.dart';
import 'package:cocktailr/src/utils/layout_utils.dart';
import 'package:flutter/material.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, SizingInformation sizingInformation) builder;
  
  const ResponsiveBuilder({Key key, this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return LayoutBuilder(builder: (context, boxSizing) {
      var sizingInformation = SizingInformation(
        deviceScreenType: getDeviceScreenType(mediaQuery),
        screenSize: mediaQuery.size,
        localWidgetSize: Size(boxSizing.maxWidth, boxSizing.maxHeight),
      );

      return builder(context, sizingInformation);
    });
  }
}
