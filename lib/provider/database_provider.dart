import 'package:flutter/cupertino.dart';
import 'package:podliczator2000/model/planner.dart';
import 'package:podliczator2000/model/procedure.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider with ChangeNotifier {
  List<Planner> _planners = [];
  List<Planner> get planners => _planners;

  List<Procedure> _procedures = [];

  String _searchText = '';
  String get searchText => _searchText;
  set searchText(String value) {
    _searchText = value;
    notifyListeners();
  }

  List<Procedure> get procedures {
    return _searchText != ''
        ? _procedures
            .where(
                (p) => p.name.toLowerCase().contains(_searchText.toLowerCase()))
            .toList()
        : _procedures;
  }

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

  Future<List<Planner>> getPlanners(String date) async {
    final db = await database;
    return await db.transaction((txn) async {
      return await txn.query(plannerTable,
          where: 'DATE = ?', whereArgs: [date]).then((data) {
        final converted = List<Map<String, dynamic>>.from(data);

        List<Planner> plannersList = List.generate(
            converted.length, (index) => Planner.fromString(converted[index]));

        _planners = plannersList;
        notifyListeners();
        return _planners;
      });
    });
  }

  Future<List<Procedure>> getProcedures() async {
    final db = await database;
    return await db.transaction((txn) async {
      return await txn.rawQuery(
          '''SELECT procedure.id, procedure.name, procedure.amount, procedure.category_id, category.name as CATEGORY_NAME, price_list.name as PRICE_LIST_NAME FROM procedure INNER JOIN category ON procedure.category_id = category.id INNER JOIN price_list on category.price_list_id = price_list.id''').then((data) {
        final converted = List<Map<String, dynamic>>.from(data);

        List<Procedure> proceduresList = List.generate(converted.length,
            (index) => Procedure.fromString(converted[index]));

        _procedures = proceduresList;
        return _procedures;
      });
    });
  }
}
