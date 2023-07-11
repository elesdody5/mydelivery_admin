import 'package:path/path.dart';
import 'package:quickorder/data/local/entity/local_quick_order_table.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static final instance = AppDatabase._();

  static Database? _database;

  AppDatabase._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('my_delivery_admin.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path,
        version: 1, onCreate: LocalQuickOrderTable.create);
  }
}
