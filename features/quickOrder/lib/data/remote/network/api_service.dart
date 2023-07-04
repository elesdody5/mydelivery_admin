import 'package:core/domain/quick_order.dart';
import 'package:core/model/response.dart';
import 'package:core/model/shop.dart';

abstract class ApiService {
  Future<ApiResponse> addQuickOrder(QuickOrder quickOrder);

  Future<ApiResponse<List<Shop>>> getAllShops();

  Future<ApiResponse> removeQuickOrder(String? id);
}
