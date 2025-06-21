import 'package:supplier_connect_app/model/login_model.dart';

import '../services/auth_service.dart';


abstract class LoginView {
  void onLoginSuccess(String token);
  void onLoginError(String message);
}

class LoginPresenter {
  final LoginView view;
  final AuthService _authService = AuthService();

  LoginPresenter(this.view);

  void login(String email, String password) async {
    try {
      final LoginResponse response = await _authService.login(email, password);

      if (response.status) {
        view.onLoginSuccess(response.token ?? '');
      } else {
        view.onLoginError(response.message);
      }
    } catch (e) {
      view.onLoginError(e.toString());
    }
  }
}
