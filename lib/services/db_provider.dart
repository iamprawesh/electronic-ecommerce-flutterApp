import 'package:electronic_ecommerce_flutterapp/models/product.dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  static Database? _db;

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + "electronic_ecom.db";
      _db = await openDatabase(
        _path,
        version: 1,
        onCreate: (db, version) {
          print(db);
          print("db");

          return;
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<void> createTable() async {
    try {
      print("Hello from createTable");
      // todo  - flock id must be there
      await _db!.execute(
        "CREATE TABLE product(id INTEGER PRIMARY KEY, name TEXT NOT NULL, image TEXT NOT NULL, price TEXT NOT NULL, quantity INTEGER)",
      );
    } catch (e) {}
  }

  Future<int> insertProduct(CartProduct product) async {
    int result = 0;

    result = await _db!.insert('product', product.toMap());
    print(result);
    print("result");
    return result;
  }

  static Future<List<CartProduct>> retrieveProduct() async {
    try {
      final List<Map<String, Object?>> queryResult =
          await _db!.query('product');
      return queryResult.map((e) => CartProduct.fromMap(e)).toList();
    } catch (e) {
      throw Exception("Some error");
    }
  }

  static Future<void> deleteProduct(int id) async {
    try {
      await _db!.delete(
        'product',
        where: "id = ?",
        whereArgs: [id],
      );
    } catch (e) {}
  }

  static Future<int> updateQuantity(int id, int quantity) async {
    try {
      Map<String, dynamic> row = {
        'quantity': quantity,
      };
      await _db!.update(
        'product',
        row,
        where: "id = ?",
        whereArgs: [id],
      );
      return 1;
    } catch (e) {
      return 0;
    }
  }

  static Future<int> dropTable(String tableName) async {
    try {
      await _db!.execute("DROP TABLE IF EXISTS $tableName");
      print("droping table");

      return 1;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  // Future<Database> initializeDB() async {
  //   String path = await getDatabasesPath();
  //   return openDatabase(
  //     join(path, 'electronic_ecom.db'),
  //     onCreate: (database, version) async {
  //       await database.execute(
  //         "CREATE TABLE product(id INTEGER, name TEXT NOT NULL, image TEXT NOT NULL, price TEXT NOT NULL)",
  //       );
  //     },
  //     version: 1,
  //   );
  // }

  // Future<List<Product>> retrieveUsers() async {
  //   final Database db = await initializeDB();
  //   final List<Map<String, Object?>> queryResult = await db.query('product');
  //   return queryResult.map((e) => Product.fromJson(e)).toList();
  // }
}
