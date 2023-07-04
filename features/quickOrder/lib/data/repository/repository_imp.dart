import 'package:core/domain/quick_order.dart';
import 'package:core/domain/result.dart';
import 'package:core/model/shop.dart';
import 'package:quickorder/data/repository/repository.dart';

import '../remote/remote_data_source.dart';
import '../remote/remote_data_source_im.dart';


class MainRepository implements Repository {
  final RemoteDataSource _remoteDataSource;


  MainRepository(
      {RemoteDataSource? remoteDataSource})
      : _remoteDataSource = remoteDataSource ?? RemoteDataSourceImp();
  @override
  Future<Result> sendQuickOrder(QuickOrder quickOrder) {
    return _remoteDataSource.sendQuickOrder(quickOrder);
  }
  @override
  Future<Result<List<Shop>>> getAllShops() {
    return _remoteDataSource.getAllShops();
  }
}