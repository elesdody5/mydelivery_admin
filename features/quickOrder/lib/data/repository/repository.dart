import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:core/domain/user.dart';
import 'package:core/model/category.dart';
import 'package:core/model/offer.dart';
import 'package:core/model/product.dart';
import 'package:core/model/shop.dart';

abstract class Repository {
  Future<Result> sendQuickOrder(QuickOrder quickOrder);
  Future<Result<List<Shop>>> getAllShops();

}
