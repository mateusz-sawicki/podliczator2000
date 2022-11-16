import 'package:flutter/cupertino.dart';
import 'package:podliczator2000/model/add_planner.dart';
import 'package:podliczator2000/model/category_summary.dart';
import 'package:podliczator2000/model/planner.dart';
import 'package:podliczator2000/model/procedure.dart';
import 'package:podliczator2000/model/summary.dart';
import 'package:podliczator2000/model/summary_period.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../constants/constant.dart';

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

  String _focusedDay = Constants().formatter.format(DateTime.now());
  String get focusedDay => _focusedDay;
  set focusedDay(String value) {
    _focusedDay = value;
    notifyListeners();
  }

  SummaryPeriod _period = SummaryPeriod.daily;
  SummaryPeriod get period => _period;
  set period(SummaryPeriod value) {
    _period = value;
    notifyListeners();
  }

  List<Summary> _summaries = [];
  List<Summary> get summaries => _summaries;

  List<CategorySummary> _categorySummaries = [];
  List<CategorySummary> get categorySummaries => _categorySummaries;

  Database? _database;
  Future<Database> get database async {
    final dbDirectory = await getDatabasesPath();
    const dbName = 'podliczator2000_db.db';
    final path = join(dbDirectory, dbName);

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );

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
      await txn.execute('''CREATE TABLE IF NOT EXISTS $userTable(
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        NAME TEXT
      )''');

      await txn.execute('''CREATE TABLE IF NOT EXISTS $businessTable(
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        NAME TEXT,
        USER_ID INTEGER,
        FOREIGN KEY(USER_ID) REFERENCES $userTable(ID)
      )''');

      await txn.execute('''CREATE TABLE IF NOT EXISTS $priceListTable(
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        NAME TEXT,
        VALID_FROM TEXT,
        VALID_TO TEXT,
        BUSINESS_ID INTEGER,
        FOREIGN KEY(BUSINESS_ID) REFERENCES $businessTable(ID)
      )''');

      await txn.execute('''CREATE TABLE IF NOT EXISTS $categoryTable(
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        NAME TEXT,
        PRICE_LIST_ID INTEGER,
        FOREIGN KEY(PRICE_LIST_ID) REFERENCES $priceListTable(ID)
      )''');

      await txn.execute('''CREATE TABLE IF NOT EXISTS $procedureTable(
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        NAME TEXT,
        AMOUNT REAL,
        CATEGORY_ID INTEGER,
        FOREIGN KEY(CATEGORY_ID) REFERENCES $categoryTable(ID)
      )''');

      await txn.execute('''CREATE TABLE IF NOT EXISTS $plannerTable(
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
      return await txn.rawQuery(
          '''SELECT planner.id, planner.date, planner.procedure_id as PROCEDURE_ID, procedure.name as PROCEDURE_NAME, category.name as CATEGORY_NAME, price_list.name as PRICE_LIST_NAME FROM planner INNER JOIN procedure ON planner.procedure_id = procedure.id INNER JOIN category ON procedure.category_id = category.id INNER JOIN price_list on category.price_list_id = price_list.id WHERE planner.date = "$date"''').then((data) {
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

  Future<void> deletePlanner(int plannerId) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete(plannerTable,
          where: 'id == ?', whereArgs: [plannerId]).then((_) {
        _planners.removeWhere((element) => element.id == plannerId);
        notifyListeners();
      });
    });
  }

  Future<void> addPlanner(AddPlanner planner) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn
          .insert(
        plannerTable,
        planner.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      )
          .then((generatedId) {
        notifyListeners();
      });
    });
  }

  Future<List<Summary>> getSummary(String date) async {
    //TODO: podsumowania kasy i procedur

    final db = await database;
    return await db.transaction((txn) async {
      return await txn.rawQuery(
          '''SELECT planner.date, planner.procedure_id as PROCEDURE_ID, procedure.name as PROCEDURE_NAME, procedure.amount as PROCEDURE_AMOUNT, COUNT(procedure_id) as PROCEDURE_ENTRIES, SUM(PROCEDURE.AMOUNT) as PROCEDURE_SUM, category.name as CATEGORY_NAME, price_list.name as PRICE_LIST_NAME FROM planner INNER JOIN procedure ON planner.procedure_id = procedure.id INNER JOIN category ON procedure.category_id = category.id INNER JOIN price_list on category.price_list_id = price_list.id WHERE planner.date = "$date" group by procedure_id order by procedure.name''').then((data) {
        final converted = List<Map<String, dynamic>>.from(data);

        List<Summary> summariesList = List.generate(
            converted.length, (index) => Summary.fromString(converted[index]));

        _summaries = summariesList;
        notifyListeners();

        return _summaries;
      });
    });
  }

  Future<List<CategorySummary>> getCategoriesSummary(String date) async {
    DateTime dateInDateTime = DateTime.parse(date);

    String periodQuery =
        '''strftime('%Y-%m-%d', planner.date) BETWEEN "$date" and "$date"''';
    if (period == SummaryPeriod.daily) {
      periodQuery =
          '''strftime('%Y-%m-%d', planner.date) BETWEEN "$date" and "$date"''';
    }
    if (period == SummaryPeriod.weekly) {
      String startDay = getStartOfWeek(dateInDateTime);
      String endDay = getEndOfWeek(dateInDateTime);
      periodQuery =
          '''strftime('%Y-%m-%d', planner.date) BETWEEN "$startDay" and "$endDay"''';
    }
    if (period == SummaryPeriod.monthly) {
      String startDay = getStartOfMonth(dateInDateTime);
      String endDay = getEndOfMonth(dateInDateTime);
      periodQuery =
          '''strftime('%Y-%m-%d', planner.date) BETWEEN "$startDay" and "$endDay"''';
    }

    final db = await database;
    return await db.transaction((txn) async {
      return await txn.rawQuery(
          '''SELECT category.name as CATEGORY_NAME, COUNT(category.id) as CATEGORY_ENTRIES FROM planner INNER JOIN procedure ON planner.procedure_id = procedure.id INNER JOIN category ON procedure.category_id = category.id WHERE $periodQuery group by category.id order by category_entries desc''').then((data) {
        final converted = List<Map<String, dynamic>>.from(data);

        List<CategorySummary> categorySummariesList = List.generate(
            converted.length,
            (index) => CategorySummary.fromString(converted[index]));

        _categorySummaries = categorySummariesList;
        notifyListeners();

        return _categorySummaries;
      });
    });
  }

  double calculateTotalCategories() {
    return _categorySummaries.fold(0.0,
        (previousValue, element) => previousValue + element.categoryEntries);
  }

  String getStartOfWeek(DateTime date) {
    return Constants()
        .formatter
        .format(date.subtract(Duration(days: date.weekday - 1)));
  }

  String getEndOfWeek(DateTime date) {
    return Constants()
        .formatter
        .format(date.add(Duration(days: DateTime.daysPerWeek - date.weekday)));
  }

  String getStartOfMonth(DateTime date) {
    return Constants().formatter.format(DateTime(date.year, date.month, 1));
  }

  String getEndOfMonth(DateTime date) {
    return Constants().formatter.format(DateTime(date.year, date.month + 1, 0));
  }
}
