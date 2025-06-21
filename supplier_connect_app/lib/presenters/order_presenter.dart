
import 'package:supplier_connect_app/provider/cart_provider.dart';
import 'package:supplier_connect_app/services/auth_service.dart';

class OrderPresenter {
  final AuthService _authService = AuthService(); 

  Future<bool> placeOrder(List<CartProduct> cartItems) async {
    if (cartItems.isEmpty) return false;
    return await _authService.placeOrder(cartItems);
  }
}
