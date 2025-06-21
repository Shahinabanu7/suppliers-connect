import 'package:supplier_connect_app/model/supplier_model.dart';
import 'package:supplier_connect_app/services/auth_service.dart';



class SupplierPresenter {
  final AuthService _service = AuthService();

  Future<Supplier> getSuppliers() {
    return _service.fetchSuppliers(); // ✅ Now matches
  }
}