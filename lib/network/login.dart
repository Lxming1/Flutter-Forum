import './http_request.dart';
class LoginReq {
  static submitLogin(username, password) async {
    return  HttpRequest.request('/login', method: 'post', params: {
      "username": username,
      "password": password
    });
  }

  static submitRegister(username, password) async {
    return await HttpRequest.request('/users', method: 'post', params: {
      "username": username,
      "password": password
    });
  }
}