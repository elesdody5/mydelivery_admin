import 'package:sqflite/sqflite.dart';

class LocalQuickOrderTable {
  static const tableName = 'local_quick_orders';

  static const columnId = 'id';
  static const columnAddress = 'address';
  static const columnInCity = 'inCity';
  static const columnDescription = 'description';
  static const columnPhoneNumber = 'phoneNumber';
  static const columnCount = 'count';
  static const columnDateTime = 'dateTime';
  static const columnImageFilePath = 'imageFilePath';
  static const columnRecordFilePath = 'recordFilePath';
  static const columnPrice = 'price';
  static const columnDeliveryPickedTime = 'deliveryPickedTime';

  static Future create(Database db,int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnAddress TEXT,
        $columnInCity INTEGER,
        $columnDescription TEXT,
        $columnPhoneNumber TEXT,
        $columnCount INTEGER,
        $columnDateTime TEXT ,
        $columnImageFilePath TEXT,
        $columnRecordFilePath TEXT,
        $columnPrice INTEGER
      )
    ''');
  }
}