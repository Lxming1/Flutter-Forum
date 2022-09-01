import 'package:untitled/network/http_request.dart';

class MomentReq{
  static addMoment(String content) async {
    return await HttpRequest.request('/moment', method: 'post', params: {
      'content': content
    });
  }

  static setLabel(List labels, momentId) async {
    return await HttpRequest.request('/moment/$momentId/labels', method: 'post', params: {
      'labels': labels
    });
  }
}