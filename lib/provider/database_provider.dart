import 'package:podliczator2000/model/category.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  List<Category> _categories = [];
  List<Category> get categories => _categories;

  Database? _database;
  Future<Database> get database async {
    final dbDirectory = await getDatabasesPath();
    const dbName = 'podliczator2000_db.db';
    final path = join(dbDirectory, dbName);

    _database = await openDatabase(path, version: 1, onCreate: _createDb);

    return _database!;
  }

  static const userTable = 'USER';
  static const businessTable = 'BUSINESS';
  static const priceListTable = 'PRICE_LIST';
  static const categoryTable = 'CATEGORY';
  static const procedureTable = 'PROCEDURE';
  static const plannerTable = 'PLANNER';

  Future<void> _createDb(Database db, int version) async {
    await db.transaction((txn) async {
      await txn.execute('''CREATE TABLE $userTable(
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        NAME TEXT
      )''');

      await txn.execute('''CREATE TABLE $businessTable(
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        NAME TEXT,
        USER_ID INTEGER,
        FOREIGN KEY(USER_ID) REFERENCES $userTable(ID)
      )''');

      await txn.execute('''CREATE TABLE $priceListTable(
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        NAME TEXT,
        VALID_FROM TEXT,
        VALID_TO TEXT,
        BUSINESS_ID INTEGER,
        FOREIGN KEY(BUSINESS_ID) REFERENCES $businessTable(ID)
      )''');

      await txn.execute('''CREATE TABLE $categoryTable(
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        NAME TEXT,
        PRICE_LIST_ID INTEGER,
        FOREIGN KEY(PRICE_LIST_ID) REFERENCES $priceListTable(ID)
      )''');

      await txn.execute('''CREATE TABLE $procedureTable(
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        NAME TEXT,
        AMOUNT REAL,
        CATEGORY_ID INTEGER,
        FOREIGN KEY(CATEGORY_ID) REFERENCES $categoryTable(ID)
      )''');

      await txn.execute('''CREATE TABLE $plannerTable(
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        DATE TEXT,
        PROCEDURE_ID INTEGER,
        FOREIGN KEY(PROCEDURE_ID) REFERENCES $procedureTable(ID)
      )''');
    });
  }

  Future<List<Category>> getCategories() async {
    final db = await database;
    return await db.transaction((txn) async {
      return await txn.query(categoryTable).then((data) {
        final converted = List<Map<String, dynamic>>.from(data);

        List<Category> categoryList = List.generate(
            converted.length, (index) => Category.fromString(converted[index]));

        _categories = categoryList;
        return _categories;
      });
    });
  }
}
