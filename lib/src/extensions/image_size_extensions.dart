import 'package:cocktailr/src/models/enum/image_size.dart';

extension ImageSizeExtensions on ImageSize {
  String get stringValue {
     switch (this) {
      case ImageSize.SMALL:
        return "small";
      case ImageSize.MEDIUM:
        return "medium";
      case ImageSize.LARGE:
        return "large";
      default:
        return "small";
    }
  }
}
