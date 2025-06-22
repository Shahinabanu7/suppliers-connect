import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supplier_connect_app/model/login_model.dart' show LoginResponse;

import 'package:supplier_connect_app/model/product_model.dart';
import 'package:supplier_connect_app/model/supplier_model.dart';
import 'package:supplier_connect_app/provider/cart_provider.dart';

class AuthService {
  final String apiUrl = 'http://ec2-13-60-206-177.eu-north-1.compute.amazonaws.com/supplierconnect';

  // Login function
 Future<LoginResponse> login(String email, String password) async {
  print("email: $email");
  print("password: $password");
  print("API URL: $apiUrl/login.php");

  try {
    final response = await http.post(
      Uri.parse('http://ec2-13-60-206-177.eu-north-1.compute.amazonaws.com/supplierconnect/login.php'
        //'$apiUrl/login.php'
        ),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return LoginResponse(
        status: true,
        token: data['token'] ?? '',
        message: 'Login successful',
      );
    } else if (response.statusCode == 401) {
      return LoginResponse(
        status: false,
        token: '',
        message: 'Invalid email or password.',
      );
    } else {
      return LoginResponse(
        status: false,
        token: '',
        message: 'Something went wrong. Please try again later.',
      );
    }
  } catch (e) {
    print(" Login Error: $e");
    return LoginResponse(
      status: false,
      token: '',
      message: 'Connection failed: $e',
    );
  }
}


  // Fetch suppliers

  Future<Supplier> fetchSuppliers() async {
    print('Fetching suppliers...');
    final response = await http.get(Uri.parse('$apiUrl/supplier.php'));

    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['success'] == true) {
        final List<dynamic> data = jsonResponse['data'];
        return Supplier.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load suppliers');
      }
    } else {
      throw Exception('Failed to load suppliers');
    }
  }

  Future<SupplierDetail> getSupplierDetails(String id) async {
    final response = await http.get(Uri.parse('$apiUrl/suppliersd.php?id=$id'));
    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return SupplierDetail.fromJson(jsonData);
    } else {
      throw Exception('Failed to load supplier details');
    }
  }

  Future<bool> placeOrder(List<CartProduct> cart) async {
    final url = Uri.parse('$apiUrl/orders.php');
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer abcd1234",
    };

    final cartJson = cart.map((item) => item.toJson()).toList();

    final body = jsonEncode({"cart": cartJson});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['success'] == true;
    } else {
      return false;
    }
  }
}








