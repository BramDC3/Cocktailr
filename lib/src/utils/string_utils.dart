import 'package:cocktailr/src/models/enum/image_size.dart';

class StringUtils {
  static String capitalizeAllWords(String name) {
    if (name == null || name.length <= 1) return name?.toUpperCase() ?? "";
    if (!name.contains(RegExp(r"\s+")))
      return "${name[0].toUpperCase()}${name.substring(1)}";

    return name
        .trim()
        .split(RegExp(r"\s+"))
        .map((word) => word.length > 1
            ? "${word[0].toUpperCase()}${word.substring(1)}"
            : word.toUpperCase())
        .join(" ");
  }

  static String getSizeFromImageSize(ImageSize imageSize) {
    switch (imageSize) {
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
