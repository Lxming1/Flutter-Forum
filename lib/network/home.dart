import './http_request.dart';
class HomeReq {
  static getMoments(pagesize, pagenum) async {
    return HttpRequest.request('/moment?pagesize=$pagesize&pagenum=$pagenum');
  }

  static comment(content, momentId) async {
    return await HttpRequest.request('/comment', method: 'post', params: {
      'momentId': momentId,
      'content': content
    });
  }

  static replyComment(commentId, content, momentId) async {
    return await HttpRequest.request('/comment/$commentId/reply', method: 'post', params: {
      'content': content,
      'momentId': momentId
    });
  }

  static getComment(momentId) async {
    return await HttpRequest.request('/comment?momentId=$momentId');
  }
}