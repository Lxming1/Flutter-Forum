
import 'dart:io';
import 'package:untitled/utils/meida_type.dart';

import 'package:path/path.dart' as path;
import '../utils/share_preferences.dart';
import './http_request.dart';
import 'package:untitled/config/http_config.dart';
import 'package:dio/dio.dart';

class ProfileReq {
  static sendAvatar(file) async {
    var imgFile = await MultipartFile.fromFile(
      file.path,
      filename: 'avatar',
      contentType: MediaTypeUtil.getMediaType(path.extension(file.path))
    );

    FormData formData = FormData.fromMap({
      "avatar": imgFile,
    });

    return await HttpRequest.request(
      '${HTTPConfig.baseURL}/upload/avatar',
      params: formData,
      method: 'post'
    );
  }
}