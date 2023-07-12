import 'dart:convert';

import 'package:quickorder/data/local/entity/local_quick_order.dart';
import 'package:quickorder/data/local/entity/local_quick_order_table.dart';

import '../db/app_database.dart';

class QuickOrderDao {
  final AppDatabase _instance;

  QuickOrderDao({AppDatabase? instance})
      : _instance = instance ?? AppDatabase.instance;

  Future<int> insertQuickOrder(LocalQuickOrder quickOrder) async {
    final db = await _instance.database;
    return db.insert(LocalQuickOrderTable.tableName, quickOrder.toJson());
  }

  Future<LocalQuickOrder?> getQuickOrder(int id) async {
    final db = await _instance.database;
    final quickOrderJson = await db.query(
      LocalQuickOrderTable.tableName,
      where: '${LocalQuickOrderTable.columnId} = ?',
      whereArgs: [id],
    );
    if (quickOrderJson.isEmpty) return null;
    return LocalQuickOrder.fromJson(quickOrderJson[0]);
  }

  Future<void> deleteQuickOrder(int id) async {
    final db = await _instance.database;
    await db.delete(
      LocalQuickOrderTable.tableName,
      where: '${LocalQuickOrderTable.columnId} = ?',
      whereArgs: [id],
    );
  }

  Future<List<LocalQuickOrder>?> getScheduledQuickOrder() async {
    final db = await _instance.database;
    final quickOrdersJson = await db.query(LocalQuickOrderTable.tableName);
    return quickOrdersJson
        .map((quickOrder) => LocalQuickOrder.fromJson(quickOrder))
        .toList();
  }
}
