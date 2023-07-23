import 'database_helper.dart';

void testDb() async {
  // Get a reference to the singleton instance of DatabaseHelper
  final dbHelper = DatabaseHelper.instance;

  // Data to insert
  Map<String, dynamic> row = {
    DatabaseHelper.columnProduct : 'Product 1',
    DatabaseHelper.columnInDay  : '2023-07-18',
    DatabaseHelper.columnOutDay : '2023-07-20',
    DatabaseHelper.columnInPerson: 'In-person 1',
    DatabaseHelper.columnOutPerson: 'Out-person 1',
    DatabaseHelper.columnTotalNumber: 100,
  };

  // Insert data into the database
  await dbHelper.insertInventory(row);

  // Get all data
  List<Map<String, dynamic>> inventories = await dbHelper.queryAllInventories();
  print('Fetched data: $inventories');
}
