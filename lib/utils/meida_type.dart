import 'package:http_parser/http_parser.dart';

class MediaTypeUtil {
  static MediaType? getMediaType(final String fileExt) {
    switch (fileExt.toLowerCase()) {
      case ".jpg":
      case ".jpeg":
      case ".jpe":
        return MediaType("image", "jpeg");
      case ".png":
        return MediaType("image", "png");
      case ".bmp":
        return MediaType("image", "bmp");
    }
    return null;
  }
}