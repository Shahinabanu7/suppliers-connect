import 'package:supplier_connect_app/model/product_model.dart';

import 'package:supplier_connect_app/services/auth_service.dart';

class SupplierDetailPresenter {
  final AuthService _service = AuthService();

  Future<SupplierDetail> fetchSupplierDetail(String id) {
    return _service.getSupplierDetails(id);
  }
}
