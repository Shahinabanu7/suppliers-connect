import 'package:flutter/material.dart';

import 'package:supplier_connect_app/constants/colors.dart';
import 'package:supplier_connect_app/presenters/login_presenter.dart';
import 'package:supplier_connect_app/views/supplier_list_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginView {
  late LoginPresenter _presenter;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // bool isLoading = false;
  String _message = '';

  @override
  void initState() {
    super.initState();
    _presenter = LoginPresenter(this);
  }

  bool _isLoading = false;

  @override
  void onLoginError(String message) {
    setState(() {
      _isLoading = false;

      //_message = 'Login Failed: $message';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  onLoginSuccess(String token) async {
    // Optionally store the token
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('auth_token', token);
    if (!mounted) return;

    setState(() {
      _message = 'Login Success! Token: $token';
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SupplierListScreen()),
    );
    // Save token and navigate to supplier list screen here
  }

  void _onLoginPressed() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _message = 'Please enter email and password';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _message = '';
    });
    _presenter.login(email, password);
  }

  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: lightpurple,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Login with your email and password',
                  style: TextStyle(fontSize: 14, color: lightpurple),
                ),
                SizedBox(height: 160),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    filled: true,
                    fillColor: lightgrey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: lightpurple),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,

                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: 'Password',

                    filled: true,
                    fillColor: lightgrey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: lightpurple),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: lightpurple,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: lightpurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      _isLoading ? null : _onLoginPressed();

                      print("login");
                      print(_message);
                      //  _onLoginPressed();
                    },

                    child:
                        _isLoading
                            ? SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                            : Text(
                              'Login',
                              style: TextStyle(fontSize: 24, color: white),
                            ),
                  ),
                ),
                SizedBox(height: 20),
                Text(_message),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
