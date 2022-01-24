import 'package:core/model/order_status.dart';

class OrderActionModel {
  OrderStatus status;
  String actionTitle;

  OrderActionModel({required this.status, required this.actionTitle});
}
