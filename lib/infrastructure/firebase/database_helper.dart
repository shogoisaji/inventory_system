import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "InventoryDB.db";
  static final _databaseVersion = 1;

  static final table = 'inventory';

  static final columnId = 'id';
  static final columnProduct = 'product';
  static final columnInDay = 'in_day';
  static final columnOutDay = 'out_day';
  static final columnInPerson = 'in_person';
  static final columnOutPerson = 'out_person';
  static final columnTotalNumber = 'total_number';

  // Singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Database reference
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnProduct TEXT NOT NULL,
        $columnInDay TEXT NOT NULL,
        $columnOutDay TEXT NOT NULL,
        $columnInPerson TEXT NOT NULL,
        $columnOutPerson TEXT NOT NULL,
        $columnTotalNumber INTEGER NOT NULL
      )
      ''');
  }

  // Insert data into the database
  Future<void> insertInventory(Map<String, dynamic> inventory) async {
    Database db = await instance.database;
    await db.insert(table, inventory);
  }

  // Get all data from the database
  Future<List<Map<String, dynamic>>> queryAllInventories() async {
    Database db = await instance.database;
    return await db.query(table);
  }
}
